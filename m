Return-Path: <linux-kernel+bounces-818440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F36B591C6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148AB3A46FC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675F8287271;
	Tue, 16 Sep 2025 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UREZ0rDx"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC74E1891AB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013791; cv=none; b=rQMals4qj3i7ryaiBcCGs3w0todAJJpy7RfjmHZwCJVz+jZH9xAC3Idax0pzMwaIrQI5PR7dYq6I6exQoIsFuN0admes1TVTMVdKlwl20Dj2llOoa5GiKXaoQLh8x4LHft16TaNXHKtpwfQOJIvGXP0LPbvxJjEChiWXNAenCTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013791; c=relaxed/simple;
	bh=lOHXQvIUSxAv+i/2v6FmlZCTC48RTraw3Eaj90AyRPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTcVYwM1rbTH8n7Kz7nMN6A/9EP+eAnzMCuLgHcTWR+i1l211+Ocd4mo+fgf6gQsDOYT+V1UEeEsjN+I0wLUceo85gmB/n3xb/bj2Gte3cMhnXh9Qp79TFs06rvOnopRHvEgn11ndpYg05CEt7Dzx+bXcSqk0WKRuvDdo5qVuqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UREZ0rDx; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ecbcc16948so228738f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758013788; x=1758618588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lOHXQvIUSxAv+i/2v6FmlZCTC48RTraw3Eaj90AyRPs=;
        b=UREZ0rDxYGUl2e+TF9Ae6QufMr37T4LUIk77l2VHs1xz9gyVFKe7OytXPevEJ62VtL
         HZB+hK3WZFyDTLlsPhZa7Ai8NCcg8ahkEUy1PiFBuw8C98Eu9vJMyrrsrbqqvnt6/M1c
         VwpUzjQ7o0U9dpOUCxzg7IQVI8ubH3F8uiCgVv2NIwiEhd5hm2RI4SA8q13BFSq8oe0l
         WdWD75nVo8eLs6BGTCcQH9ECNBe37i1wzkpXfApCRyVMMIxdo2RJWW+OA4QvuhIDJGXc
         G/3VNY6h++kmaMHbFnb98EZZE2wnFSxoKXxZFiyfizJ9QyG81s2XGf6EFkiB0Nwcbldi
         txFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758013788; x=1758618588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOHXQvIUSxAv+i/2v6FmlZCTC48RTraw3Eaj90AyRPs=;
        b=T3xbs6LpDuZqvacyFevQZj6C4B1CrV9ltnzEJHYqGUtauf3KNX4wQ5sowakzMYGFw1
         hU/ik0a16boa3qcBvpkliIiZSbx+iWWw+eN0VleXOkBQ6pIkxWTIZ8afFmFgGBPzg9ce
         7P/qLJkowq8ZdtC3DyaOM/Pft3E812pleff9v3vqOxFSqPaOT28uw+7DAwbe2x13ehuy
         ULMncCzfhRhDGWiMQOt8h7AkAqAx48fGzbxAWAg0eH0CGsWgaQzu33sLOvS3QJ111n9J
         ekeSNTUzE9LtjTUL/GZ4mk43CmzNUf6tNg/nSOAKmwl0FIOOW/TqOk9ewYpVkb73KeXb
         +fEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLBPpFplz+TaIXKAPl+c7KjrogQVBBKV78id3RbxA38g4BoCbU5tcZ2Unc+pISzVAao5KQ2JQCjjDlsmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8so64qJMapQHCIWaJT4GI5Dx6jhVE5tLr4StpLWIgX6ltvv+R
	q3gJnr/f+uvOAKbhWifdYFuCp5XKNNZ2PifqY4rTXRa4njRPgH9RDpRVXBFZbWtqLLM=
X-Gm-Gg: ASbGncueNXLhIxdEGh2Jz3f2c+yvMhLmllJRBAbUCh3XAERGaX4W48Ilq8biocYd8BY
	YMpP/R1G2pR9FxpWbAwj8ZsVMjBpkaBSsL2PYx7jcrMpXIUKAtH+4Lbe2Rp5L66LJg6X32A7g/I
	+iYfNRjQDFtBf53bZIVtwunv6oE1VjXVRiXc9yb+zvhJYVXo/lvjU1kGbTVNSY6CVoHEU4G1CuW
	3kn4+taoKlUD8K7lQ/LXbZQfNjH1SkQ1AY/Dqda+rwzJEwL05l9+Ok06CZcK8E0aUXCigYghrPR
	6tCW0Y51Jtydc6NQN8hOGa0qrN0u0xIXeBD8Fc61G1koTBOtwPbZKSlNFKFbKKj8iBloeU1nnw9
	qRRsZDT02FhUwvgT29x+8h0nVPbP4t0m3lOuQThyoknE=
X-Google-Smtp-Source: AGHT+IHRX2AFKU0LKzCoZznAC/kheMtWYH3iHVIEQVTnsevoAP+gCVTmNB8FKkGRPN1HQbOz5LP8yQ==
X-Received: by 2002:a5d:5f94:0:b0:3d8:7c6e:8ad4 with SMTP id ffacd0b85a97d-3e765781242mr15404357f8f.10.1758013787976;
        Tue, 16 Sep 2025 02:09:47 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7e645d1fcsm15364025f8f.48.2025.09.16.02.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:09:47 -0700 (PDT)
Date: Tue, 16 Sep 2025 11:09:45 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	shashank.mahadasyam@sony.com, longman@redhat.com, tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Report failed rt migrations to non-root
 cgroup without rt bandwidth under RT_GROUP_SCHED
Message-ID: <6zi6fp2kgs2hjychav3rrf22qwwskegdq53ew33tfn7rylueik@slugq2khaakw>
References: <20250916011146.4129696-1-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hbf7oqequ4mdexeh"
Content-Disposition: inline
In-Reply-To: <20250916011146.4129696-1-atomlin@atomlin.com>


--hbf7oqequ4mdexeh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] sched/core: Report failed rt migrations to non-root
 cgroup without rt bandwidth under RT_GROUP_SCHED
MIME-Version: 1.0

On Mon, Sep 15, 2025 at 09:11:46PM -0400, Aaron Tomlin <atomlin@atomlin.com> wrote:
> Following on from commit c7461cca91 ("cgroup, docs: Be explicit about
> independence of RT_GROUP_SCHED and non-cpu controllers"), this patch
> introduces an explicit error message that informs the user why the
> task migration failed. Now user-mode has a clear and actionable reason
> for the failure, greatly assisting with debugging.

The action in this case should be to assign non-trivial quota to target
task_group (or un-rt the task), no?

What setup do you envision for this message? (CONFIG_RT_GROUP_SCHED and
cgroup v2?)

Thanks,
Michal

--hbf7oqequ4mdexeh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaMkpVxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AgawAD/fVZXRaDm/1vyXRu5p1CA
yc8c92xBpXDGU0+/2mayaIkA/2jKhCAETP4kIAxg9/kKEyHShtcxOfExGoBod/hv
vP8H
=YcfG
-----END PGP SIGNATURE-----

--hbf7oqequ4mdexeh--

