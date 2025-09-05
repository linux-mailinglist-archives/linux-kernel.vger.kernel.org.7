Return-Path: <linux-kernel+bounces-802724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B45B4560A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F9E3B15CE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CAF343D93;
	Fri,  5 Sep 2025 11:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oTQxL3O+"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC44343D7D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070846; cv=none; b=TQrrTtIgDCLo804gm6DpGTlFvDmNFgxgM9d09tF3fCCK89OHw47tjztyEhRBFB3HeDXSDyh/DBrcNXRn3GHjLVDT1eugYK9rFNHrlpGdj0pa42XdB7ehlLaKKQCIAl7CK6J5im/7/gARHFDUo0NvJ7bk3Ot/kw/N7pUEuRD1Hlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070846; c=relaxed/simple;
	bh=A6YZY+2lgCDRWE7jZhtd0wPHGCzmsRLPirzvJ650XSA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MV1cXRehKHSv80frY2PDvJfcjAroX5xqIAG6B+P4ICkN3hdIQ7hi/jbpsrpumI7rhqF9iGtgtDbXsZ4esPxYn/g9TrVcF8soMWJnLdPAJehDQzuC46/0E28GCqPxkBPES+wbsAEPUatbPEWAt+oUwey+P6uugXaPJ6dkO4M8j48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oTQxL3O+; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e98b75eb577so2243542276.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 04:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757070843; x=1757675643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smIFcZT6fRwTwOdoLCuotEOilxdiZ96AHCt5ydM2TdI=;
        b=oTQxL3O+flcMzzH3qTc3DJJ676coZBx8GslfzSoL4kUeg2gHPqkSBjb/+PRhRABHTV
         cfl5QGTEaCy3lST2Op+RDJ+qjZnWpFF3vC7vTGjUmyxQt85QH+N7P+bu2yaAUvSwSfLv
         2k5cuMaYguWsNsfFoApHupr6QNs4elRzhA7O6jQII4/AoLbVGFOBLpfKpeDeCsz0gm5C
         w30L/yPMqwDFXGv9aAUSqLM/LO7EkQvhALIO+crNIJ1cYSi7PI6O86lRpnx83lb6h4vS
         8WfLvHewTGEIQHoh31bJn7gGNFvLxy/ww0/Op3q4+9Xo1Jn9vI9EJP86AjSZKC8zaQty
         o7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757070843; x=1757675643;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smIFcZT6fRwTwOdoLCuotEOilxdiZ96AHCt5ydM2TdI=;
        b=tayy7Asu2ZCnRacK1ChkM/hLFnQadEbPkv5ldQ6IGyU9/4/C3+QkZIlbUoBw2HbAsn
         804q54gF7gVExRxwB/Wodc8dYJIFrDy4LHqGNQj+VQK5QsgUD8k+uQtDdSBMoWd8R/OP
         yvdwr0B1Dec5fq/HeLHbVBwgNRhz6606aRC17xxnQPP3ZIEB+tg8E9lpwEH0nh/FX88s
         TlGgqbfnJerF4BEFADRoMt+VAUjazmzh1d/xf2QTqMjX6HyA5lFn1vUWjfwnt+uWl9/U
         1TAYK1AsVJEa3mqdPmS4uXLtPiMsU16ig2WtJo+C0QQF9eERTuyTHM+yM94ZLTtl3xlG
         /2aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwzxkRLHFPBWLHDHmOdwQ3p8g8TJ5eU/P6JvhAyQbb+/r0rr1YgT5LiOlskTDfSoBSCJnK7b2NDFC17X4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ifp8On7oAbi2JeviKKIxm7IID83c6W0idgUo36RBMciMFcTS
	NQ+I2m1cm84UskYxTTsMvvdDw/cUffROjfKHlTc3Bi8u6p7cXYjk+qFTi3IDnK9sVQPFe8895bA
	tYxBc
X-Gm-Gg: ASbGncttGr3ea8wc60rltWtv4P+2rqSXSRhG/axm8nJJobqdLWgm0z2a1qMLLlX7OLY
	pYsjOM2JCdGJ6sMUtfXc8jt9jnkvJ8zc1UKr3YLiCfDchOrrc3Eie+vow2Mc1qWIGvWdLVXEyO9
	vdLBEBaeELgJE+G+Ze/Ph85KuAZVG11X3a6swfGHTDP257cov9KgyOLPBl3ETfEN/Z6OMPAWO2v
	FdpiGTMJM7y8orAYU7Ct3Ib8DZDlIChnoALcxZOM/W+GWCl6Gh1cQiFByL4ntZ33qLPktlVRiPU
	8m1+7qyjtyN4a6sSn5f9EPx3xF255kO5vrFhVfZpu07Zc90RN3ntFQDXwb5vawktCgk93X8cLH1
	cj3aNooYAXvvpyDVk2g==
X-Google-Smtp-Source: AGHT+IH+J3QMzNBHejPE3u8sZJfVn0k75y2u6I63HrlNeAIS2gwpm3hKHIkQcZo1cU57jjmcfNQLEw==
X-Received: by 2002:a25:6407:0:b0:e95:3010:1124 with SMTP id 3f1490d57ef6-e9db04d274amr2050532276.18.1757070843085;
        Fri, 05 Sep 2025 04:14:03 -0700 (PDT)
Received: from [127.0.0.1] ([50.227.229.138])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9bbdf57266sm2999999276.14.2025.09.05.04.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 04:14:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250905012535.2806919-1-csander@purestorage.com>
References: <20250905012535.2806919-1-csander@purestorage.com>
Subject: Re: [PATCH] io_uring/rsrc: initialize io_rsrc_data nodes array
Message-Id: <175707084146.356946.8866336484834458029.b4-ty@kernel.dk>
Date: Fri, 05 Sep 2025 05:14:01 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Thu, 04 Sep 2025 19:25:34 -0600, Caleb Sander Mateos wrote:
> io_rsrc_data_alloc() allocates an array of io_rsrc_node pointers and
> assigns it to io_rsrc_data's nodes field along with the size in the nr
> field. However, it doesn't initialize the io_rsrc_node pointers in the
> array. If an error in io_sqe_buffers_register(), io_alloc_file_tables(),
> io_sqe_files_register(), or io_clone_buffers() causes them to exit
> before all the io_rsrc_node pointers in the array have been assigned,
> io_rsrc_data_free() will read the uninitialized elements, triggering
> undefined behavior.
> Additionally, if dst_off exceeds the current size of the destination
> buffer table in io_clone_buffers(), the io_rsrc_node pointers in between
> won't be initialized. Any access to those registered buffer indices will
> result in undefined behavior.
> Allocate the array with kvcalloc() instead of kvmalloc_array() to ensure
> the io_rsrc_node pointers are initialized to NULL (indicating no
> registered buffer/file node).
> 
> [...]

Applied, thanks!

[1/1] io_uring/rsrc: initialize io_rsrc_data nodes array
      commit: 0f51a5c0a89921deca72e42583683e44ff742d06

Best regards,
-- 
Jens Axboe




