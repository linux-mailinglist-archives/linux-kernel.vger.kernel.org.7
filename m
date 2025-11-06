Return-Path: <linux-kernel+bounces-887587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD4FC38A85
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 02:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914223B8F0D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 01:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAB81F92E;
	Thu,  6 Nov 2025 01:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="aSUQa2LO"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4278686334
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 01:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762391016; cv=none; b=O+SHwWMs0R7ohEptsEhUbdQA2cTNGa8skSJAJK3Gd6J/mQTonhXOXz2/tJm3tbHwPtZbp1RKK5B54gcSfjI5PAGYJiAqUwVUU5rqTQBkYo+YdOkOyN1JS+QnP1qdZracfqOOhnvm3UAqezVQcIuDK8Kj99MpbBmlPqgXzk54Yi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762391016; c=relaxed/simple;
	bh=+73RZCPpxQC9yANrGPBX5TF6IsgfWoNUyYsmUrSk5xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPOqmAEhFELhtPVWmbiSB12b7HA+GCHKJnoO/KMcw4JYUC+MQGcR9fXk28QiIH5aFEgRptjTAZyt9TNp7BWpoqAHMI5Rb59m6CwXN/6IU0aRWS/xHfi41MqmLSfY3r40KJLSNdOFn1qyYvQUl86XPoFdYp0o/kaxIsUYRQcZPbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=aSUQa2LO; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-340c680fe8cso455156a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 17:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1762391014; x=1762995814; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6bjRpGWsW4TRP4Ax/+K4LJR81TWknrhesm5uonlPs8k=;
        b=aSUQa2LOf5/+ijJrMW9Y9A9P0A6ITH4HgsLocttI5kXiNm0P6bhe0GdVUGfkLKaL0H
         fvBRQt9YaTE1lPeC1OqTN9BgIEcHrPBed5ent1eUyC0KttM4ooD3hPdDzyWkgNBtX0AB
         sovQMDsobZnqIsIqciC3quq6TOw1krv5+7Pp4F8PMWcw2OE0q/hhW83dO+lLVH6TFdr8
         4pcabmS3jmt8kELeIbMjK0FAWWh01VkttRCU+HWzgFNDkS8tT+MZSMtmXgzZomKYNsCL
         S/dC5z8bBKj0x2lG8CBI2/IdBjnb87WIEZPdwMWUssEpQVU7OAtumm0qR5iPb/jWEcuG
         w+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762391014; x=1762995814;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6bjRpGWsW4TRP4Ax/+K4LJR81TWknrhesm5uonlPs8k=;
        b=ogmzBadW74AOlM/zsA0NhGu36qbATH7bENGyx8ZGOVQ1Hz7l1gn+a7MIelEtT9dFeh
         8U+l846b8C2XYRWrMJILmXVL+g70WD/bIvwuuzUIcXL2O5nw4QMXZKSXf7AFYeFulv2V
         Xlqm3ghoNBs9NK6oc5m4bFtwf5uXahXsFO8Wc09lbsHVuHjg7tYMrSq6+QBQkf8IWLG2
         tFlaJV1hE2l8BajzCvEc0DBpEHZnVVYggL4h4Dic5A+GAKMuy26ppdOc4OMpLEwyYajb
         r7S2W8BxaZ8E+kHmOrKzfYEc9QY0zXfyx7Xn1NbRxaVDlnbuy0ZNTTuuDJfRgwmZP8Cm
         6FOw==
X-Forwarded-Encrypted: i=1; AJvYcCXAZOxnqFd5J3V3P30/7JWZ6ah76iG423W7b09FFY3Fm9A35kJsNzhWERmlSZ9OIURPn+jgLwud+qi/bOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyPE+e3HtSekmDfu2rPjNg328DKox7P1Beku09ogMCuLnN5RlZ
	7DoxbnKR9ggk/Awut8o0PFwcnD8TNAcPEdgQsCLP9KCfsdKWmaDbzwEGNMZkD7JSIsCazkdhJx8
	Qc9v5
X-Gm-Gg: ASbGnctOy4PD7b+ox7FJsuP+wwsTmpGguzdVTDg5AaD6jt0H2TzMrdwne+ZzOq32ZLi
	hXbt8hNlEb/R12Yf7cExrmUMroaL5mHyHdTlIbf9VfOFaIY8Zh7nx5mw3oxy0+P3I6Y2bisVvA1
	QhL41vNgTl3iDlHUlftEtYZPfzLEEUNudE3iFsEAKfTqT6TL5DecV/I/a6WdqGPsXos8TFY9sbE
	j5cHPrtT37NriqPRuwMcS9xIfw5QQ71yirVhpCCI2gLiXwK72/ejkkSrfw+wTC1hR5e73ukxa2M
	kb/WUV0RYR17Lt6EvpDYBGdvQiz8RsIf3TS8wicWhx82PebE4b2k0F1kcJ+UTr+q5MwvIQro5HE
	zFNXuLwRf9Am3q8fFPk5Ld/jgUIxA6iAeODRsLUv17bMFlA2Q11/qjo8ZjzeYoIzvasGRRtBmkb
	oqkzDXbagMA42I
X-Google-Smtp-Source: AGHT+IEpH2Wah6V2nDJDiuPZBapJbtEvSKo3kVP73NflBVaMfkdYrd8D55Y/16u/3dc+1jOQGZR4Yg==
X-Received: by 2002:a17:90b:28c3:b0:341:88ba:c6d3 with SMTP id 98e67ed59e1d1-341a6ddf6ffmr5760754a91.23.1762391014475;
        Wed, 05 Nov 2025 17:03:34 -0800 (PST)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68ad143sm4153358a91.3.2025.11.05.17.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 17:03:34 -0800 (PST)
Date: Wed, 5 Nov 2025 17:03:31 -0800
From: Calvin Owens <calvin@wbinvd.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>
Subject: Re: [QUESTION] Order-4 allocation failures on reads with 256bit csums
Message-ID: <aQvz42UTgwx7zFrO@mozart.vkv.me>
References: <20251105180054.511528-1-calvin@wbinvd.org>
 <cc115783-7b1c-4196-a06d-08008277141c@suse.com>
 <0f137e3f-7b9b-4fbe-a8f7-2c90dad1a5fc@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f137e3f-7b9b-4fbe-a8f7-2c90dad1a5fc@suse.com>

On Thursday 11/06 at 07:31 +1030, Qu Wenruo wrote:
> 在 2025/11/6 07:24, Qu Wenruo 写道:
> > 在 2025/11/6 04:30, Calvin Owens 写道:
> > > Hello all,
> > > 
> > > I'm seeing order-4 allocation failures reading from btrfs filesystems
> > > with blake2b/sha256 checksums, on a couple different machines.
> > > 
> > > I don't think I'm doing anything interesting: in both cases they were
> > > idle except for a single-threaded file reader doing buffered I/O. The
> > > first one was an x86 QEMU VM, the second was a raspberry pi 4b (below):
> 
> Another thing is, although the order 4 allocation is indeed large, it's not
> that unreasonable large.
> 
> The problem is still that we're requiring physically contiguous range which
> greatly reduce the chance to get one.
> 
> Another point contributing to this is the order 4, which is beyond the
> PAGE_ALLOC_COSTLY_ORDER (3), thus no more retry is done thus can fail here.
> 
> In fact for your aarch64 case, you can configure the kernel to use 64K page
> size and in that case such allocation will only be one page thus will almost
> never fail.
>
> This leads to my final question, what's the memory size of the RPI4 and your
> qemu VM?
> My guess is there is a very limited amount of memory (1GiB?), but still a
> lot of large buffered IOs.
> I guess enlarging the VM RAM size will hugely reduce the chance of memory
> allocation failure.

Thanks for looking Qu.

Both have 8GB of RAM, here's the rest of the allocfail trace from the pi
in case it's interesting:

    Mem-Info:
    active_anon:56 inactive_anon:3262 isolated_anon:0
     active_file:421253 inactive_file:1487506 isolated_file:0
     unevictable:0 dirty:51 writeback:0
     slab_reclaimable:28851 slab_unreclaimable:13163
     mapped:6531 shmem:13 pagetables:493
     sec_pagetables:0 bounce:0
     kernel_misc_reclaimable:0
     free:39062 free_pcp:34 free_cma:15
    Node 0 active_anon:224kB inactive_anon:13048kB active_file:1685012kB inactive_file:5950024kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:26124kB dirty:204kB writeback:0kB shmem:52kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB kernel_stack:3472kB pagetables:1972kB sec_pagetables:0kB all_unreclaimable? no Balloon:0kB
    DMA free:48336kB boost:12288kB min:19692kB low:21540kB high:23388kB reserved_highatomic:2048KB free_highatomic:2032KB active_anon:0kB inactive_anon:80kB active_file:274560kB inactive_file:545700kB unevictable:0kB writepending:0kB present:970752kB managed:880012kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:60kB
    lowmem_reserve[]: 0 3008 6962 6962
    DMA32 free:53372kB boost:10240kB min:36236kB low:42732kB high:49228kB reserved_highatomic:2048KB free_highatomic:2016KB active_anon:32kB inactive_anon:124kB active_file:971292kB inactive_file:1993632kB unevictable:0kB writepending:24kB present:3080192kB managed:3080192kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
    lowmem_reserve[]: 0 0 3954 3954
    Normal free:54540kB boost:16384kB min:50560kB low:59104kB high:67648kB reserved_highatomic:2048KB free_highatomic:2032KB active_anon:192kB inactive_anon:12844kB active_file:439160kB inactive_file:3410608kB unevictable:0kB writepending:180kB present:4194304kB managed:4049512kB mlocked:0kB bounce:0kB free_pcp:136kB local_pcp:0kB free_cma:0kB
    lowmem_reserve[]: 0 0 0 0
    DMA: 12*4kB (UM) 11*8kB (UM) 53*16kB (UMEH) 40*32kB (UMH) 18*64kB (UMH) 47*128kB (UMH) 34*256kB (UMH) 39*512kB (UMH) 10*1024kB (UMH) 0*2048kB 0*4096kB = 48344kB
    DMA32: 14*4kB (UME) 16*8kB (UME) 806*16kB (UMEH) 194*32kB (UMEH) 29*64kB (UEH) 50*128kB (UM) 34*256kB (UMEH) 22*512kB (UMH) 4*1024kB (UMH) 1*2048kB (M) 0*4096kB = 53656kB
    Normal: 3*4kB (U) 6*8kB (U) 10*16kB (UEH) 31*32kB (UMEH) 35*64kB (UMEH) 45*128kB (UMH) 13*256kB (MH) 74*512kB (MH) 4*1024kB (UH) 0*2048kB 0*4096kB = 54524kB
    Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
    Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=32768kB
    Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
    Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=64kB
    1909321 total pagecache pages
    532 pages in swap cache
    Free swap  = 16764072kB
    Total swap = 16777212kB
    2061312 pages RAM
    0 pages HighMem/MovableOnly
    58883 pages reserved
    16384 pages cma reserved


