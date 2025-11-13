Return-Path: <linux-kernel+bounces-898513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E810EC55714
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B4D3B06FA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0282FC86C;
	Thu, 13 Nov 2025 02:30:49 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDD28248C;
	Thu, 13 Nov 2025 02:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763001048; cv=none; b=fnAX8/nFY67jcNFiEVFBTClBph2H830v++M3WGzAXRfpE5wEuEaHLOP3cG0OHOhAEJhjfFh3HxXoyfiQeJQIshiipwk3t1RWtuSijSw51GCsIUUimHBkyUtl9Jy8Pp9rb7OO/TWyNmCrEpDWOliHpkmKO6Bs4vxLGnDdX4zx2FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763001048; c=relaxed/simple;
	bh=31PCfrreYrZ++waB2Ulpo4M51w728qBoU3m/Oh5gQNc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g/MvZdPyOqM/+fjsR9zNYWUQ3gQxL/3cLyOc4hgKd+Xsk4fqgxHR1YFee30JJZd3S/fbg3RoBiBKSRRE2EapxG3uq/Vv0wv7ngpkP0S4seQ8eg13R6UKlMZljbgYRDdLWhvlVlvFkts/WomWnLyjiWH8lf1alh1Ymi7jYUyH36k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 248AF1A0737;
	Thu, 13 Nov 2025 02:21:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id E75B02F;
	Thu, 13 Nov 2025 02:21:03 +0000 (UTC)
Message-ID: <1dfa1e3566cafbe43a1d4753defef9c82ddb3b64.camel@perches.com>
Subject: Re: [PATCH v3 07/22] checkpatch: Warn on page table access without
 accessors
From: Joe Perches <joe@perches.com>
To: Samuel Holland <samuel.holland@sifive.com>, Palmer Dabbelt	
 <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	linux-riscv@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>,
  David Hildenbrand	 <david@redhat.com>, linux-mm@kvack.org
Cc: devicetree@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>, 
	linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>, Michal Hocko
	 <mhocko@suse.com>, Conor Dooley <conor@kernel.org>, Lorenzo Stoakes	
 <lorenzo.stoakes@oracle.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Alexandre Ghiti	 <alex@ghiti.fr>, Emil Renner Berthing <kernel@esmil.dk>,
 Rob Herring	 <robh+dt@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, "Liam
 R . Howlett"	 <Liam.Howlett@oracle.com>, Andy Whitcroft
 <apw@canonical.com>, Dwaipayan Ray	 <dwaipayanray1@gmail.com>, Lukas
 Bulwahn <lukas.bulwahn@gmail.com>
Date: Wed, 12 Nov 2025 18:21:01 -0800
In-Reply-To: <20251113014656.2605447-8-samuel.holland@sifive.com>
References: <20251113014656.2605447-1-samuel.holland@sifive.com>
	 <20251113014656.2605447-8-samuel.holland@sifive.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: E75B02F
X-Stat-Signature: 637x6efm4mgrsxn5df3wupihd98x8qr7
X-Rspamd-Server: rspamout06
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19giTHWCQXhnf4xIrV8ypTp+gyVUJdqk4E=
X-HE-Tag: 1763000463-251880
X-HE-Meta: U2FsdGVkX1/zAceZ5vnh4tbWR1f+Cwm6Gajb5Cysjq6qV34Cj9ZhK7eypGnKqYKEn8aGGYIrbdej0PNanG4Y7TU/rQFSPu393I2CQtbbB+tC8raIaQXcfTo4/QsU+zfgvxgvrkbI2t+kILkdA2MOrD1E61pPCOZlLL5D27VIEclZ4WR5+L5e2bEJGUcPo/3BvvjYsMlCufHb2LdyCWotOP9G0jDRsl191XUc0vokRa6gejGK8FjkEibcUKMjgguRZP81NCcHiR4kBfuLcisXBHTUQG1ReqMmWiKYx9A+Ot1h30HMlHgxWYbe8+ei1wEa

On Wed, 2025-11-12 at 17:45 -0800, Samuel Holland wrote:
> Architectures may have special rules for accessing the hardware page
> tables (for example, atomicity/ordering requirements), so the generic MM
> code provides the pXXp_get() and set_pXX() hooks for architectures to
> implement. These accessor functions are often omitted where a raw
> pointer dereference is believed to be safe (i.e. race-free). However,
> RISC-V needs to use these hooks to rewrite the page table values at
> read/write time on some platforms. A raw pointer dereference will no
> longer produce the correct value on those platforms, so the generic code
> must always use the accessor functions.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -7721,6 +7721,13 @@ sub process {
>  				ERROR("MISSING_SENTINEL", "missing sentinel in ID array\n" . "$here\=
n$stat\n");
>  			}
>  		}
> +
> +# check for raw dereferences of hardware page table pointers
> +		if ($realfile !~ m@^arch/@ &&
> +		    $line =3D~ /(?<!pte_t |p[mu4g]d_t |izeof\()\*\(?(vmf(\.|->))?(pte|=
p[mu4g]d)p?\b/) {
> +			WARN("PAGE_TABLE_ACCESSORS",
> +			     "Use $3p_get()/set_$3() instead of dereferencing page table poin=
ters\n" . $herecurr);
> +		}
>  	}

Seems like a lot of matches

$ git grep -P '(?<!pte_t |p[mu4g]d_t |izeof\()\*\(?(vmf(\.|->))?(pte|p[mu4g=
]d)p?\b' | \
  grep -v '^arch/' | wc -l
766

Is this really appropriate?

trivia:

izeof is really odd looking.  I'd prefer sizeof.

