Return-Path: <linux-kernel+bounces-799554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0639B42D7B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DEB8582059
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1EE2F5324;
	Wed,  3 Sep 2025 23:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DrXH5bNF"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125DD2F0C6E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 23:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756942582; cv=none; b=sElLVJ9Dd+8dPaOhAsy1Na1uTfvlW/FK/MkRvIJbVPJ8XkS5KsLqkyApZjnUsqUcEt4RoADla17HtkdhFz0L+P6QKnAYAff5Ua+4ZUR/1WCYVJK3/tWi5vt67JvWmESyMmL6CVP5Q+dk2iunasG/0ctJxdeW9Od/Et7HmKeVZH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756942582; c=relaxed/simple;
	bh=hTsUf+7pIdM/lXCqAe9D86CNr2C3O5JzzF0WNrYSDIU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JlAdXq2empjiKKtVRSaxgMylw9BMUAAj7Wi5TSuihWbMhaVXIu/vtcIlch4KWbOZjbIWbYl0cctG25JcQAp1UOW0Q4M0j9EbWZF9wwiKPCWw04RZf4PtS/CI9SwYVPfulZOMegbkim6zAxJ6/PSa67BeqDwXBsOQftvCMYnMQOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DrXH5bNF; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3ecbe06f849so3438215ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 16:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756942579; x=1757547379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpgLGMWO0awdNrt/VLr9OxSO9rXyxL66JQE1TwfW2uw=;
        b=DrXH5bNFOFDGGBA7a5ba+H5TbdMgdKJAPsxeN4Wj+n6XUT19vlRnPmbEcboKP2x9/q
         vKe72MjpspPHgJO1O6V/2Z0OmngQ34mgRZjowDqlobqLsQgo6zn1pR5GP86rJwsQheDO
         0YyMvNhINfsQnp+ik5KdD04ddXO5arfXG3oW0d+iXpmBsqxAFHw8hjVRlxbBh06l1ZHj
         PfUlnJkIbXrsX0JivnIvFsdtN3dCxkdjB0db3X/lUY/+cZ73q7yRKm6RYe89yMQmObkH
         wv5XzJqZ1DhvieyJr2PM6cfSnQlM9kqTD6VtDUBXvcPQyc3266cRyS+K+jfbB667qKb1
         dCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756942579; x=1757547379;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpgLGMWO0awdNrt/VLr9OxSO9rXyxL66JQE1TwfW2uw=;
        b=Cfd+q50z9f4A0wO7PUmN6R2InA5LzF39p3T9S7fT2v3+94zD1seLXakMziZc2jlHrs
         cvX7tgDyBFqoHueLZWV3pFVwBu4CAieigJ+ZSMiz9moULM0IOCn/89WGZIBPHDIvSlL+
         TYCgphsZ7NK8yDJ3K494cUx8FzM8msXasXrmT5EehTbbFRiVJn3QQ2UYEOhy0HuvgBb+
         w8VM0HpJ1cbhn2SO2rB7MbX4uhH79yLC77nUDmv6q2+1B5hwSpYAA9TfA3BkLdZ76o04
         6m+DstNSK/f/Qjvzk2QY18hVTdMW5PuXUbadx83fZlBiIioEu45PQV8vPJEyGWkwgqcc
         +Rcg==
X-Forwarded-Encrypted: i=1; AJvYcCUg5HgQN8fVLTX9oENE7ddWxGvf5sAR0CeFkdQP4BtL57z5BSmtrucotHUrxgGgSED0veV7hZtR1KoMn8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLklEu69B+tClhG4HFwOUIdCZrREDSoWs+QuTRZwJv4O2dUHBo
	nsxCQSI5wX7pmy9gGerapmcKof2lWpW3pR3lFkmJQXYAJq0q4VYstP2z8R5IJYifDV6bZXYMXoX
	h099I
X-Gm-Gg: ASbGncvuYTUGOInOBKkVa0FgOevdagcpvLdNU3zUS1oAt7kUwRNu4pcJaYwSlPGnxcq
	htvcBc+QUMkiSDcLl8vn9iGGU8cbf/eQ4GHcQUyYQGCQSh5slqSXJV++APawRv3t/iCIxtPDjqD
	taBVVVgHL6QD5oou0NGYF7+AI0dUeyuhNuTq5mrV5CynWg3PYJYucykACim7Wfyfj64HoRsZZdB
	gQDeKXRmSYawdez2AjyWWtgov7VaH5OaRBgXcA2kkPU9TNw7lnALSC7+IUsnwrbG1qxL8nxOmey
	zyYcaHylX4yMA+nD5v7z9DK4F48oTX5P8GtDFqNRjfL/DK8EWiEqCArtQkiL95bkMLqcMw/7ri+
	fJ3xmGHG3Hpyc6ljkYZqVL427toPS7nJdQk8Z
X-Google-Smtp-Source: AGHT+IHnXqc+QrXXfnvVjSXU+Urf58cLLyfm4Xz21aO3AQHu4oJHxvNC61ADrYGkuPGDXqoCBDPmSw==
X-Received: by 2002:a92:cda5:0:b0:3f6:6228:33d3 with SMTP id e9e14a558f8ab-3f662283597mr46635955ab.19.1756942579489;
        Wed, 03 Sep 2025 16:36:19 -0700 (PDT)
Received: from [127.0.0.1] ([70.88.81.106])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3f65d1ef2c7sm18736855ab.5.2025.09.03.16.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 16:36:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250808153251.282107-1-csander@purestorage.com>
References: <20250808153251.282107-1-csander@purestorage.com>
Subject: Re: [PATCH] ublk: inline __ublk_ch_uring_cmd()
Message-Id: <175694257775.217330.8898056117894470803.b4-ty@kernel.dk>
Date: Wed, 03 Sep 2025 17:36:17 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Fri, 08 Aug 2025 09:32:50 -0600, Caleb Sander Mateos wrote:
> ublk_ch_uring_cmd_local() is a thin wrapper around __ublk_ch_uring_cmd()
> that copies the ublksrv_io_cmd from user-mapped memory to the stack
> using READ_ONCE(). This ublksrv_io_cmd is passed by pointer to
> __ublk_ch_uring_cmd() and __ublk_ch_uring_cmd() is a large function
> unlikely to be inlined, so __ublk_ch_uring_cmd() will have to load the
> ublksrv_io_cmd fields back from the stack. Inline __ublk_ch_uring_cmd()
> into ublk_ch_uring_cmd_local() and load the ublksrv_io_cmd fields into
> local variables with READ_ONCE(). This allows the compiler to delay
> loading the fields until they are needed and choose whether to store
> them in registers or on the stack.
> 
> [...]

Applied, thanks!

[1/1] ublk: inline __ublk_ch_uring_cmd()
      commit: 225dc96f35afce6ffe3d798ffc0064445847a63b

Best regards,
-- 
Jens Axboe




