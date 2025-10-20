Return-Path: <linux-kernel+bounces-861643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B135CBF33F4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04B73B43DF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A996127AC31;
	Mon, 20 Oct 2025 19:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="C7j93pow"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F4A2D9EDD
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760989242; cv=none; b=sNjFq0AD92Btg8ZSrpPSBnCnncp3v7aOxwGTpIKgSATTZXOtndnoIy0sa7OD1n3cR6ZgVh5ZOGrEIldGdD/7TXxi45zfSnY3sMB1PHHSq1xMjhs02Nj8lQAOFhb6e9IDPuwlWo1WNZ7/TMaFHLV3TXdZRr101s8hK4Cnlw6XATU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760989242; c=relaxed/simple;
	bh=KHk7R4MpmD0tSWaJ3FGaAMpViTQt1Vx8oYaNaI+3JYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kg3Fgjo1k24AhLhKZikxjC+pomhWgqZKxpxBzfPXPYi68BDAPisFDiDRW/lBlVLIm5nLsUU236XOWV5gawVmuuy9IH77vV59dgS3PU6U7duvG6KVvTy2MteKTfyf0cSebukvYlbWGHUFc0EaR/RkXVnpqyk8bCTuePGH+JTDoeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=C7j93pow; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8901a7d171bso597567185a.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760989240; x=1761594040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnmEnPP8bfaJAvDeM1NTDj1+/Fjxn0k170ygaThNRUs=;
        b=C7j93pow9sbrPWXkmg1bOQYmVLOANyaQwkUL7cy5biZ1xvIaCYtRcYjsDdBupoquLB
         g0P7uNUg7zxR61ex2hJbFPp4H7/nfqQPVTJ6d7DGJX9yKGyp/kNQcO98fpZ3qIxLnIfr
         IRTPr8BmekcTVNiWFuo7GNvctT/QoWEUqxZq/KUEAI6jTQ3el87jC6l/i2r59+IvQxPh
         b6POKLaQpbzFXmF/Q22orP/Gg7zzNjAnJmjUAF/rT60yYHb4+6+fc2CnnOzw3Fm38qfZ
         nRflXPDC0RABR8NVlfHH4dm852Ijd/D9suz/sDiyx9i20WX3RiXprwUqMxEiuxKEcbeo
         jeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760989240; x=1761594040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnmEnPP8bfaJAvDeM1NTDj1+/Fjxn0k170ygaThNRUs=;
        b=VvZ0o2OFV9H6GHAoII64KArEhHcFj33xhgR3atbvkA1UQlk3R+TXtrAiTxb3jI55m4
         Ont3tej0A0qvVZZqbt+J7C7lk5fWrJ6FmRTvg/eifDFNcRmvkbC/S7W6zoeZOXjKHHJ5
         zKKmjJnNYEBgaM5gpsCOI/SJyzfw+vsi7m5Gf418cjVzpOvFaNXPix5EEEtjMF/JTWIC
         UXExdYCLRjSjenFcCayHefWV5QkZZltjNSYSrPiwNOZRj5u3K8HDplyEcQGunqOGJ6Vc
         jXyEtfkjlVmV5SS5GXrnuk7mEey4q5ADoM01Tpx1eSaTsH9jLCiMyTOWwe+Xe8qaqJBf
         NVmw==
X-Forwarded-Encrypted: i=1; AJvYcCWlfVFHFeKHg4WWWrUfpIJvw/PaX2rv28PoLIQr9y2w59L8bQkjBlIaIookw+T4aA6CJz1kr3+ITYhQqY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiesckKz8xn+Y2avuvaNRAx60+mEwtJdjLVHx7D3H2altvOeO3
	Lz8Tr/C/0oZvt2nFRG3BRA1TT0Cs0evKgznPGMZNkihxRDIoV9wCRV+eNX/iwBOvoas=
X-Gm-Gg: ASbGncsxyiqzM20tme5yTmcXdzbH736TGXx6RdxVQUlM6jdwrLOFxqw36X4bdZLJkIS
	5Uhdcsnaunx9tkruP36Kd6vmdOVUPdPw3m/vtgsyYjqOf9R/FbmZb26DpuE28vJR68HQNgut27l
	kAL/K8DB4qAOoyM6rCokV4WQS03XaZHRqw2jcNCNtM2kw0HDTNEhVmmIrGu3Y1oI+tkw8MXALpR
	y5Wmnl+nu9IDQLRoYbfD25VbVVBudop34BsUVkFr08qIDjnr6WbcNvpQaO0WpZhEZ2tbWnqNMkU
	gPCwh12QpSic3v78uKhdZbj0LwKXlTNgBdqEni9GqzhXxLGe7otjmUuI4VohkILiNjndx0SABU4
	U1Yn4nX/InaTyLqX+inBwYcbhQstiqcb7yUP2Ng+mzzdrs71jj7Mf3L+Dmf6KhEfasVFyQe50X2
	n625Zc6CQkEIml8N8SE1DnRVNSFC+bgZ3xWOdWDr2DZoGsB/PrUhn9EyMfF4FhD6TXqzQwpQ==
X-Google-Smtp-Source: AGHT+IGuWZHEavHisVU9mk6gRIHhpdyd/lI8SERMr7lwjiSLbTWdMYvofhTVk+g9pKS5DS+eGwkHMQ==
X-Received: by 2002:a05:620a:1710:b0:892:93df:3bdb with SMTP id af79cd13be357-89293df3e88mr974477885a.31.1760989239691;
        Mon, 20 Oct 2025 12:40:39 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cefba77asm621032185a.33.2025.10.20.12.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 12:40:39 -0700 (PDT)
Date: Mon, 20 Oct 2025 15:40:37 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org
Subject: Re: [RFC PATCH] page_alloc: allow migration of smaller hugepages
 during contig_alloc.
Message-ID: <aPaQNYsN_YPDOwQG@gourry-fedora-PF4VCD3F>
References: <20251020170615.1000819-1-gourry@gourry.net>
 <487730c6-423a-4a03-a668-9b9ff92a5cfb@redhat.com>
 <aPZ0OKx_VnQ4H_w1@gourry-fedora-PF4VCD3F>
 <609E7E01-33A6-4931-AC89-1F4B2944FB64@nvidia.com>
 <272c425a-b191-4eef-af6e-2bca1db7a940@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <272c425a-b191-4eef-af6e-2bca1db7a940@redhat.com>

On Mon, Oct 20, 2025 at 09:18:36PM +0200, David Hildenbrand wrote:
> > 
> > Basically, what is the right way of checking a folio order without lock?
> > Should we have a standardized helper function for that?
> 
> As raised, snapshot_page() tries to stabilize the folio best it can.

is snapshot_page() even worth it if we're already racing on flag checks?

i.e. there's already a race condition between

	pfn_range_valid_contig(range) -> compaction(range)

on some bogus value the worst that happens is either compaction gets
called when it can't compact, or compaction doesn't get called when it
could compact - either way, compaction still handles it if called.

We may just skip some blocks (which is still better than now).

--

on compound_order - from mm.h:

/*
 * compound_order() can be called without holding a reference, which means
 * that niceties like page_folio() don't work.  These callers should be
 * prepared to handle wild return values.  For example, PG_head may be
 * set before the order is initialised, or this may be a tail page.
 * See compaction.c for some good examples.
 */

Seems like the correct interface given the scenario. I'll poke around.

~Gregory

