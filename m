Return-Path: <linux-kernel+bounces-865574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B591BFD725
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C23265692DC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D356735B14B;
	Wed, 22 Oct 2025 16:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RBdBgzab"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908BC26FA57
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761152258; cv=none; b=O4pqL9V7gyI2pduwoShKQ8EPViVD+43O0sGpLS9mmKDSRiWjUVIHuA0XuU0QYEhZCALZWG29oxYPyFh/18LaT9HI73xpa3iv0px1czAi91P6yNO1euwVvZ+tMeMRH0FTh0hlyLuKAoinMctS48jqg3SowXZNxSA4n3QFR4TfAOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761152258; c=relaxed/simple;
	bh=hz2KqnJT/1JP4zm0gBrv2S99SgX5tWoir1yn4WqaUY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QyUumdHy+j6EgWbiSq+wSKXYkwNNDRXAdrKi25JbyiU0eK7ko3rfJk/bP1FqurBa++ymfNjUtQInnX49pU/eVZ+fRKTXYDUHEd09GD1azGjDecPVrQKFcVkmNinYMTp1Cyam8H5mABqJMV0/eCM1lisEOeaUihV7YM68t2+45dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RBdBgzab; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-93e89a59d68so191353739f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761152256; x=1761757056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3SNWmBNYycnFMnZ9ltyZrYni0qC8gln3cSgfx8uUxIo=;
        b=RBdBgzaba/H3vvg61IDR+bL6p8XgsWvnauSJdWYXg+TgeoVklLReuiCo2YcQqMjXNK
         kAG+HL1Dpe+2PiDhySuVlCOtqymIgZFwBYX6pTQyFY0PXXebEZedliKOrZiAFot955iJ
         wGlZXE3W6GjOSu0RUKhyWIQVZMbTP1SoWAszIwQuKJ322aaBYsZz3TNbPWFH4D0iPvzb
         R/ly/Ez89OI4kd9yG88p40OT+MHHd/h7yKjFHj/swBJ65+JZNopO62v5jeZz+lEgn7aZ
         P7eE5pSoki0Uhn278MlKL0WQ70Eu0uH74uaBoYA2Eyov7PH8aAAZv7fW1wPjz4PK6TKB
         pWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761152256; x=1761757056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3SNWmBNYycnFMnZ9ltyZrYni0qC8gln3cSgfx8uUxIo=;
        b=Wia7N7KRhzQWgQf351xTMtu2Z2rvI+C8CiR+jtGd+NaNCEg+rWUAd4MMR6vkXQt3Zr
         cDuRj1nt51gwU1b6E3QY/1nVhu179GntzQPCkUZcgBN+LLJq08DIRRWyutZBawXiTpNs
         S5OWmV/L/qGR/xwUcYQrSP3JLnKPBdTGqSWlVa7XSfVC7eiNdL1Ho8MZAlNCoCke0BLU
         Wgv5RbGIAvWGg2Ncv8YNVBQ2JTJw7rpSB5xKBTbg6unBnfB8+uBVf6Aa4jfW1Uf1vgC4
         xGaWJpzvMtNT758FvsdYV6w+UNUZsRnBRoTPPJPm3fDViXndz1QGx6WY9ZG3ym+151u8
         y0FA==
X-Forwarded-Encrypted: i=1; AJvYcCUg4c4e+3mjt50WUJ1q7b+TEfYW7WH1lQ+lEwk6R+0wkjqjKHp/Pyg0JzvvdddOySbBrAA42Gvar8tRa+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwc/KS9y8TkJaakuwJYFiuVv68GfilZZhH0M4iNIS7VLJrAZNt
	QSFhnQZAQqKOOJnw2q1tFQ/PL90ecwq5MU4Z2DBxwHkebwNqx+jzJWJC6LBVMDzJ5+E=
X-Gm-Gg: ASbGncuPEZAzFIKVMbi1OGg9NsjgBoiKfQqFbkxlBjVfkKPY7RUEUOgBjQaG07bGZ6B
	vwEcfO48oiK5+EYsj4z/+IGXssgMtXPjFVGGS0vzMu97EA/ngvI04WXQWgiAYJr4i1jHm+gkMz8
	276u7u9QtYQG1ca+bUTaXuZfVP7Vdd6D8YHg4f35LWJJ9NVVXhIbxVN5FJ7nILIApY5XrnFrDlr
	j7zxVKe0BUwtJOEAsc0xV3ZnOSna/q6sKdvopQMN4TkRk9TsuDfi4B2AMcRkFRnRDTd+9zvvHh9
	vHXaA3NKmhYAMxiawXhcIzcjmIyDRylavC/HlqVr1f09JFYp4DU7NpYTnzGChms8eFTjzIL5DhR
	Bv3+6VYAgAjAV03Rfofo8/r05+Tu4kf7iea5PhV4WSiDfyJPsmHO21AghQS/qLIuXZLR0QWgf
X-Google-Smtp-Source: AGHT+IGPKlNGjUd+/kFqtPdz++PqNdakIcxbRREmNQI9XmJnEqFPibBabXY2XO9gisYboHJmL2raag==
X-Received: by 2002:a05:6602:6409:b0:901:3363:e663 with SMTP id ca18e2360f4ac-93e76451522mr3282152639f.13.1761152255605;
        Wed, 22 Oct 2025 09:57:35 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e866ca57bsm533243639f.14.2025.10.22.09.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 09:57:34 -0700 (PDT)
Message-ID: <daa4b583-b978-4e08-89eb-3ccc316f7ad0@kernel.dk>
Date: Wed, 22 Oct 2025 10:57:33 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] general protection fault in
 io_uring_show_fdinfo (3)
To: syzbot <syzbot+ea6ffa4864ebe64e7a04@syzkaller.appspotmail.com>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <68f90cc1.a70a0220.3bf6c6.0020.GAE@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <68f90cc1.a70a0220.3bf6c6.0020.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Bad commit, fixed up in current tree:

#syz invalid
-- 
Jens Axboe


