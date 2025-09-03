Return-Path: <linux-kernel+bounces-799552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4ACB42D78
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D623A4877D4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4893D2ECEBB;
	Wed,  3 Sep 2025 23:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="aZPtmu3P"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C225327A12D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 23:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756942579; cv=none; b=NuN4mlBoyPShu4PN/NLCiC2vzfgNcCO7jsaflGBXZVqawSO6XqOCBhl6SXYXdb2gSX2t9ItYgQRqeYrGksogJun0sQ5ZypZNeP6Z1AA/yFeUWb1XxlJHMmhlQX5u1eRRlBMc1bIVE4gwaJcupn0SnHq+RGUmZ2p/mAr0+fH6F5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756942579; c=relaxed/simple;
	bh=/t6Z8H3NwIy8+S6CNXWoHvLmbi8OygDmjfDTRxG96hw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pwaMqHdxNzXW3mqaKLsX4Ruv0zYcrgtiAoqj8JtPtFh03q118VI0TCCC96K53nlmF07L2Rilr+QiIQtrOyoQvLbx4dVp0kHOrJzJLqrtQaEK1xkKNiTwhdCsi64MzFkw5OojIOSHU2uC2YtX55QStj+yd/3LjhWGS6QmtzqxvRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=aZPtmu3P; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3f664c47aafso3498645ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 16:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756942575; x=1757547375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKyoKyOWhMjBIlCVXOKYQHN7v5fEeRS1w1QnVRDSW80=;
        b=aZPtmu3PciXWGAMTCMVrMWOpMoUMOG8BXZbOh4iha/CG+S5mZaX7VZ75ZS/l6+iknZ
         qWpMOGd1nyPxo1LXSiRNF5XeMJM2nGkiIRELHSZqjj9NfbwiF+nOhxDtU/pKLBeb45aP
         4KG/No/NHyhz/b/1opnnQ22R6fEkzdOFC+cXx5zbt1nB0SKIYusTd9oSFyABDX2rmvVv
         79EpublwtDTA3RKA3NxGYDGa+zijrl+BuP4mpZDpkyfU01IS7Hkzll1oTuWrxxQZFmAA
         KJuQQ6R+JciYgFJCcRMb3e6QHrtXk7AwMl6H4Zgvi8bsVV2lf8Ttftg41OHKdIDsbBhI
         VJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756942575; x=1757547375;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKyoKyOWhMjBIlCVXOKYQHN7v5fEeRS1w1QnVRDSW80=;
        b=ncKSW0cDwOa04LmQ/zkDTCSn/Im9vt2OKWTk6t2Ve72EnoU0szPhZ2G5cUKSGmbrpX
         pIT2IR8lcudPlOyczgw1xHMo6DsiYKwIcYrP1BLPZ5MTAb/MrEwu6aOuJq/A/Osd9SmR
         04kxpZHIFCUzD7C80XTvrhzrgN3DEFZCCBbvpIBX19dBcJ/ktKoHx5weYaxwApyfz+TT
         rjvjMeJxtOuO7eqGLLaE+phQunHsTnMC3xqm2lp4ZK9xjHf1voie3RHl8sVdbkykDZWq
         yi+oW4CvtuSF96BAdxVFVvy4l7wA8AXV4VilXuM/jgIe+ybqcqD35ALi45bplkqOPu94
         C/jg==
X-Forwarded-Encrypted: i=1; AJvYcCUiQpfP6V/cpkXjxZcpxzpAKq/zbgEpLcjgbVFIi5V+Jx4sgcavJJLNMg4Qf+QTO6wF0BZDl8iqFGgLbpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZhWaucJnf0+bjWtKvDk997owOINOgbcqSnHTuuvrHU49ji4LU
	Yxa4zkiSI7peOWREV5LcvZ8uKnayBgqHTu8uffybhlNgLwON+NjyAyMvWNtbW3kwJjt880E9b3z
	KuNpf
X-Gm-Gg: ASbGnctHRzBM/U3WLIl26scIuQ/q1GWtWWu9SRwuCFghHMgW0KpMpPLKtWVX20yR4Lg
	tcH1HrR1pDLhE0nhrBNXskAue+PvSuoaWA0eSR72IoEtAfDAdkCah+ARrE9fwjGnRq5Ilx230gi
	vOw+l24971xHL9oQXfTce6f94x4lIh4VleuY1iscqsCBThmHlK8DrkqWefynqsaPOVMa8DSK9aX
	QEC/Rl9l0Czkrf8nh4JtPFemYbXzOC9f2MCDyR8ltg2N8g5LbUORS+3tSqHGnaP5XIPwpsEpw5L
	rP4Q7Idrbwh9wmPYXWvU68XxV8vBuDh5HepcCvioxNJR3iQjmEU+UdU356uR8CZVDRM4GxAiO5V
	ucJx2jj5puvC5zxU=
X-Google-Smtp-Source: AGHT+IF6+G6saPF9kCuvMbjVeIKCT3IGhTmPxGde3S/UR//Q0XlxEXkXnUpIensCY1zh9nCpxhW8AQ==
X-Received: by 2002:a05:6e02:2165:b0:3e5:51bb:9cd9 with SMTP id e9e14a558f8ab-3f400674ac2mr320132505ab.8.1756942575459;
        Wed, 03 Sep 2025 16:36:15 -0700 (PDT)
Received: from [127.0.0.1] ([70.88.81.106])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3f65d1ef2c7sm18736855ab.5.2025.09.03.16.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 16:36:14 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250902012609.1513123-1-csander@purestorage.com>
References: <20250902012609.1513123-1-csander@purestorage.com>
Subject: Re: [PATCH] io_uring/uring_cmd: correct io_uring_cmd_done() ret
 type
Message-Id: <175694257428.217330.16494503569202102693.b4-ty@kernel.dk>
Date: Wed, 03 Sep 2025 17:36:14 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 01 Sep 2025 19:26:07 -0600, Caleb Sander Mateos wrote:
> io_uring_cmd_done() takes the result code for the CQE as a ssize_t ret
> argument. However, the CQE res field is a s32 value, as is the argument
> to io_req_set_res(). To clarify that only s32 values can be faithfully
> represented without truncation, change io_uring_cmd_done()'s ret
> argument type to s32.
> 
> 
> [...]

Applied, thanks!

[1/1] io_uring/uring_cmd: correct io_uring_cmd_done() ret type
      commit: dd386b0d5e61556927189cd7b59a628d22cb6851

Best regards,
-- 
Jens Axboe




