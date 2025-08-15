Return-Path: <linux-kernel+bounces-770226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D73B278A6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F1B5C6641
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A085F1FDA89;
	Fri, 15 Aug 2025 05:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gnux/cgc"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBC51C5499
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 05:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755237116; cv=none; b=fMjRRA5Pf3Je1sN1q5hEsvublJrlk2d24BZ2nHP9lCeoxirVWTMq/tXg6o8PnavOCzSPOhf4v1fj7xfngoACcjKf4KzPk2KTmyqT7vgQvhWi9pKhKvE4luHX7jcAScnol1WbvtJSqGCbCiMbxt+lIXNnJSM/2Bta2i8OfJlexxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755237116; c=relaxed/simple;
	bh=83qHaayCeV3T/F3XnozRIUZ1NklbxfNyXIFop8uFAec=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P3QKUQz0bZIkGOeyill5ymD+vuhOSthN0hfSslWRpjvZKElMC+W/N2QTtquWIbgtU/VWyEzg7jjhWHiKZ9+v9SSJrn/uCDPSYgHPw4RUE82iFYsXtYXbYbDIpwFHL0/r71HqvpA2RXM3RV2Ap4VdbmSzV1VEpBQfE43JT2qs6/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gnux/cgc; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e2ebe86ecso2036495b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 22:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755237114; x=1755841914; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yPIUpNhjQ6AEsRDjGeq+2bkZwxUUqcPh43FblPu4aOQ=;
        b=gnux/cgcP6YeO9HhopWL6mSbAq7gnbIf5onhhaPvraVZrY1Uyc96CqEGNn6DL/c32U
         bjwB46ywut6VzI84pFAcxNjI5zyX3z2leP9kNRWjNk0mIUVHDtv/hpdKtEM9QSiDH0ZR
         nupcdxX4R3DdBc/NQ1eFCT32dQfj+rvKoct1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755237114; x=1755841914;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yPIUpNhjQ6AEsRDjGeq+2bkZwxUUqcPh43FblPu4aOQ=;
        b=lGrqOA9HD+0CBXANyk24lKH5YVN7uMrY+sDmy2hOwRV3ewrA4V5U+TzQ1TknmJH9y8
         MP/R5T2M2UE2kx8yB7ychuJGUjBIGIJhuU3GMv3/YSFvbaT5c4XzVMg/roloLJTaNnHq
         ANVlS7zboawRLFqUN33tl1rLejAOK4Xj7mvJT4dn/16KsZU9V13wRoVoip9U8LBcfQi4
         vbNgTkPGBX5MzfOat6wi1ZS9aP0nxOMiucW9KJMTyqsjsziqK/7tjX2V64tzrM6Bekma
         2+xrwBNgLFxDUm0+cvHdm8ZuU4NgLD8PhxUH2IPh0eNwUgFQMW/SCAG6fhsDFfw/xOpy
         kplQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx/SWR6TcvgsZuTUJDsQ/uWzoOoyh3SUQN2RQNT8XsRSQQpG3OgxtA+yBEdFWokMkw606gVdzYIugvkAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv8MEysnk5O61pIuAP75jIU7SWAlIVoO7+XVeLl6Kyie8THfyB
	UpmpxRDJDFirZKUgfJosc3PAXojC/tk8GKvZWf7Fgad2ijYsEyrj2zojwDF1+DxgWw==
X-Gm-Gg: ASbGncvXStuSNvkxMBrj3zMPT+NnVn4+C7f7WvWMfDlc+z2hfSynLm+JhJd46HSOyhL
	mYAgPubIjELcZy0vCSABo0JmTyMEHBaJ6ZkPxGhLela8F8F6Dl+pdnxMUF304jRhO+6H4csQdLP
	7J2JD5XzBZxbvvx2wHJbw6ufrKYyBQX9ysptmelqRdxrWs5hv1DAcYrGMnT2Zxfie7gDehGnk9B
	zXdNGTLr3tFgpIXQBvckSac6qyNIpFIZ+SRvp5DKQ+kmRHIjnFLHSEWvShAL01AtAeqVbsMoZOI
	tEYMFNS/Zli+d1XZkz5HWFHOZ9RquM4xhEDlrHmpEQx1f6kbRGw19L0W8Ee36aLN9q2ANZn+6MY
	4Ps6b4poiH+w6TL/1Jm7QMgsx
X-Google-Smtp-Source: AGHT+IFJSyBpiKOo5C13YIk4+PTK+ebPvaiWmR1lvuCNUWOKdDoo+4Xpqje9qDjgOndVHMPSNmSjOQ==
X-Received: by 2002:a05:6a00:2342:b0:76b:f0ac:e7b2 with SMTP id d2e1a72fcca58-76e447cd663mr1100191b3a.13.1755237114143;
        Thu, 14 Aug 2025 22:51:54 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:df07:bcb4:bd69:d61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4526d1ffsm379278b3a.16.2025.08.14.22.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:51:53 -0700 (PDT)
Date: Fri, 15 Aug 2025 14:51:49 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Suleiman Souhlal <suleiman@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: mm: swapin read-ahead and zram
Message-ID: <7ftwasufn2w3bgesfbp66vlchhpiuctxkhdxp24y5nzzgz2oip@pi4kdyqkl5ss>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

We are seeing an unexpected behavior under standard memory pressure
test with zram being configured as a swap device (I tested on several
LTS kernels: 6.12, 6.6, 5.4).  Namely, we observe multiple, repetitive
reads of (compressed) zram entries, sometimes in a very short time span:

...
[ 1523.345784] zram: decompress entry idx:1615265 zsmalloc handle:ffffa28c8be3ee70 obj_size:986 num_reads:188
[ 1523.365401] zram: decompress entry idx:1615265 zsmalloc handle:ffffa28c8be3ee70 obj_size:986 num_reads:189
[ 1523.385934] zram: decompress entry idx:1307291 zsmalloc handle:ffffa28c70100b50 obj_size:788 num_reads:227
[ 1523.405098] zram: decompress entry idx:150916 zsmalloc handle:ffffa28c70114fc0 obj_size:436 num_reads:230
[ 1523.475162] zram: decompress entry idx:266372 zsmalloc handle:ffffa28c4566e5e0 obj_size:437 num_reads:192
[ 1523.476785] zram: decompress entry idx:1615262 zsmalloc handle:ffffa28c8be3efe0 obj_size:518 num_reads:99
[ 1523.476899] zram: decompress entry idx:1294524 zsmalloc handle:ffffa28c475825d0 obj_size:436 num_reads:97
[ 1523.477323] zram: decompress entry idx:266373 zsmalloc handle:ffffa28c4566e828 obj_size:434 num_reads:111
[ 1523.478081] zram: decompress entry idx:1638538 zsmalloc handle:ffffa28c70100c40 obj_size:930 num_reads:40
[ 1523.478631] zram: decompress entry idx:1307301 zsmalloc handle:ffffa28c70100348 obj_size:0 num_reads:87
[ 1523.507349] zram: decompress entry idx:1307293 zsmalloc handle:ffffa28c701007c8 obj_size:989 num_reads:98
[ 1523.540930] zram: decompress entry idx:1294528 zsmalloc handle:ffffa28c47582e60 obj_size:441 num_reads:386
[ 1523.540930] zram: decompress entry idx:266372 zsmalloc handle:ffffa28c4566e5e0 obj_size:437 num_reads:193
[ 1523.540958] zram: decompress entry idx:1294534 zsmalloc handle:ffffa28c47582b30 obj_size:520 num_reads:176
[ 1523.540998] zram: decompress entry idx:1615262 zsmalloc handle:ffffa28c8be3efe0 obj_size:518 num_reads:100
[ 1523.541063] zram: decompress entry idx:1615259 zsmalloc handle:ffffa28c8be3e970 obj_size:428 num_reads:171
[ 1523.541101] zram: decompress entry idx:1294524 zsmalloc handle:ffffa28c475825d0 obj_size:436 num_reads:98
[ 1523.541212] zram: decompress entry idx:150916 zsmalloc handle:ffffa28c70114fc0 obj_size:436 num_reads:231
[ 1523.541379] zram: decompress entry idx:1638538 zsmalloc handle:ffffa28c70100c40 obj_size:930 num_reads:41
[ 1523.541412] zram: decompress entry idx:1294521 zsmalloc handle:ffffa28c47582548 obj_size:936 num_reads:70
[ 1523.541771] zram: decompress entry idx:1592754 zsmalloc handle:ffffa28c43a94738 obj_size:0 num_reads:72
[ 1523.541840] zram: decompress entry idx:1615265 zsmalloc handle:ffffa28c8be3ee70 obj_size:986 num_reads:190
[ 1523.547630] zram: decompress entry idx:1307298 zsmalloc handle:ffffa28c70100940 obj_size:797 num_reads:112
[ 1523.547771] zram: decompress entry idx:1307291 zsmalloc handle:ffffa28c70100b50 obj_size:788 num_reads:228
[ 1523.550138] zram: decompress entry idx:1307296 zsmalloc handle:ffffa28c70100f20 obj_size:682 num_reads:61
[ 1523.555016] zram: decompress entry idx:266385 zsmalloc handle:ffffa28c4566e7c0 obj_size:679 num_reads:103
[ 1523.566361] zram: decompress entry idx:1294524 zsmalloc handle:ffffa28c475825d0 obj_size:436 num_reads:99
[ 1523.566428] zram: decompress entry idx:1294528 zsmalloc handle:ffffa28c47582e60 obj_size:441 num_reads:387
...

For instance, notice how entry 1615265 is read, decompressed, then
presumably evicted from the memory, and read/decompressed again
soon after, almost immediately.  Also notice how that entry 1615265
has already went through this cycle 189 times.  It's not entirely
clear why this happens.

As far as I can tell, it seems that these extra zram reads are coming from
the swapin read-ahead:
 handle_mm_fault
  do_swap_page
   swapin_readahead
    swap_read_folio
     submit_bio_wait
      submit_bio_noacct_nocheck
       __submit_bio
        zram_submit_bio
         zram_read_page
          zram_read_from_zspool

There are several issues with this.

First, on systems with zram powered swap devices, these extra reads result
in extra decompressions, which translates into excessive CPU (S/W compression)
and battery usage.  Along with the fact that each decompression first requires
a zsmalloc map() call, which may result in memcpy() (if compressed object
spans two physical pages).

Second, the read-ahead pages are likely to increase memory pressure, as
each read-ahead object decompresses into a PAGE_SIZE object, while we
also hold the compressed object in zsmalloc pool (until slot-free
notification).

Setting `sysctl -w vm.page-cluster=0` doesn't seem to help, because
page-cluster 0 limits the number of pages read-ahead to 1, so we still
read-ahead.

Can swapin read-ahead be entirely disabled for zram swap devices?

