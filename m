Return-Path: <linux-kernel+bounces-877868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E2CC1F3D7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9ED188A366
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3356A313E1B;
	Thu, 30 Oct 2025 09:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjyamIo9"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2743133CEB5
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815831; cv=none; b=vAc8g6HAPlYmZebxQT3KvzMBl+Tvb4GuMWPTA4H33Hnl+F8tRTtNPoZHM03u4RyitdgJhKhMHA+BFVyh/l7C0zJFscXcxcUcUBLbs3k60oLle5PRaJ6wgC2fGHRWYuPIWfkJ/oHd3v5rWdwYTx9/V8xGKsrBngNXSxdknyNY+d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815831; c=relaxed/simple;
	bh=BnIpf9hcG8I6QANI+v+HvnUpylMPQT5dEVYGSmlgmkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofSoJ818Z0vwIekDVYC9g3kIRVL7FngeQTnk6gh02FVLyXVafO0NXoLCjK/9qnjw1M2KPqCvFHwIl+1F3RY2OgVQnrNRjX4u+Qd9ZTjEQa8CGftyXaTsg3XFt0bs5Og2yW9nIUq/OkQLIr9BFEXM9GYvlQnv29+sX+PLrL9B/1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjyamIo9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-294fba1997bso549735ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761815829; x=1762420629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiJKIWzvTq177G5Z1HqBbhq6LXsLpoXZ8DAbP1RW7sI=;
        b=ZjyamIo9fQVodqwAKhg7S0fbJbZzga+mt5KgDX77Ly5eCcdwsNj3dJk+3rwVI/9W95
         oa8aE8nmeTixmXYONeudtZkN++jVW0BP9Cq6vu4jDa7l3yv7XesXAJVAch7YymotdOGU
         gqtQOOysbpvh3lWjfDKHLT5t6D9xeLRzne7kcSZQL7uypSSE+LB89qHvkLVdjjdJd/EX
         l4zlcXG/2tRVIPZnrdvjZMtF+5G9te6bBNoFH2n8cnOlx4fJLCA/gKE/cYWUdhPPW6VI
         FWgSuQwzAsSgwbwzm+2uiGzXY9DDRyofFBJjCa2fyOY8aqFbfrQ27fqQJ/3B4ufi0xXO
         wUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761815829; x=1762420629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xiJKIWzvTq177G5Z1HqBbhq6LXsLpoXZ8DAbP1RW7sI=;
        b=l93huavB7jQfYh2Z5DMH3f6B13ewzcGMTi2YtBzITN9eti89fHm6y6CX/HKqDPVDaZ
         FTS6pK68MKpzqDAijU23UeXLdHcRhsYhrgRf9rIJLVUEKJRT+CEfmfRDDqrU2h/sjpNc
         ypPFFN4ZUwN8/FhLMCmIFTBX+Fmvpq087U8Kv1q4UOh7L68rkTyEktgutuD/deu3qHi3
         DUvZsfRLACTrGDyFjOFWfi/mUhoEdaO6ms/EaPaTX2GjvKiL1k42QRr4fmCoelWT5lGX
         05LGrQeOAS30AdGvWw5KMgz/UeLbb8H7QL/g/rbYLSuIsAoaonFnl+drsS6C36wEEmV5
         7TwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDvcEOt68Ys+T38+Y5StnGcT3iTqAZzxh2HeRbs5qV8CJO1f5XdJNqcxELyDRjX5w7csJv7qlcSh7URWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh4Hu1rYqi8KhZ/9FmGpBHp4zuc77IdAauE3Ja3mAra0l/0uVd
	ttm2x9IKYsU2L6p8YrLZ+y10Mbv05Ma+dqLn2YUbUHb2zsPfIamueJjE
X-Gm-Gg: ASbGncvPY/gE/he09GLP84vTxW3nCMNZ+HwfM8T1NXsNE8P8sIlii/mlRNkbjGoCqei
	Vl60pqZjnf/sP/pxh9H2VxDBf9F/3Koq6A4C+7B6kx8eosqLnvZFFIhDqZTBbiE+esv/9vH1cZS
	FitKcD7L0IlXX9xzpAOCMUzUijQ9MUgXK6TTtoJvqJKvClmZeUI2emqZTZn2duvOLfJa4R5XFKo
	oLrh/bU0lXAhlsrSdtqFt2kavfY1YI1SdmJTvJ3cm19NkHYELZgUvOkVz4InmDKCwuGet4wvzt1
	Gs6cuIc1+w6hh8VASWcW1B9umG2ZhynId1fv+PqCKQXyrf0MAk9r5IrTQOXuH3BmED5TTUyYOl3
	49h70KQ2DlGM3Wr89V7tBR7rGSkY6P3xtsMFEXJkmvH8rF7gj1Z+cqoCQbVXF1nKlBIRez+bJih
	2A
X-Google-Smtp-Source: AGHT+IEHwddQUWpun54rQcO7TrQwu6s7Rbw0jMDLSLHGGO431eRobH10Dl1uhW5PbFwDQhRzruCIvw==
X-Received: by 2002:a17:902:8c92:b0:294:9847:fbfc with SMTP id d9443c01a7336-294def6c333mr27333195ad.11.1761815829218;
        Thu, 30 Oct 2025 02:17:09 -0700 (PDT)
Received: from rock-5b.. ([45.32.55.39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e42f3fsm178469605ad.103.2025.10.30.02.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 02:17:08 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: cnsztl@gmail.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dsimic@manjaro.org,
	grzegorz@sternicz.uk,
	heiko@sntech.de,
	jonas@kwiboo.se,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	liujianfeng1994@gmail.com,
	robh@kernel.org,
	shawn.lin@rock-chips.com
Subject: Re: [PATCH] arm64: dts: rockchip: fix eMMC corruption on NanoPC-T6 with A3A444 chips
Date: Thu, 30 Oct 2025 17:16:49 +0800
Message-ID: <20251030091649.25396-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5af928c4-4b6e-489c-ad39-26cef3dd7473@gmail.com>
References: <5af928c4-4b6e-489c-ad39-26cef3dd7473@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Tianling,

On Tue, 28 Oct 2025 01:34:25 +0800, Tianling Shen wrote:
>>> May I ask you to test another patch I just posted to see if it fixes
>>> your issue?
>>>
>>> https://patchwork.kernel.org/project/linux-mmc/ 
>>> patch/1760924981-52339-1- git-send-email-shawn.lin@rock-chips.com/
>> 
>> Thank you for the patch! I will ask my friend to test it but he uses 
>> this board as a home router, so it may take a few days or weeks to 
>> report the result.
>
>Hi all, sorry for the late. My friend has tested this patch and it works 
>fine after 50 times dd operation. A big thanks to Shawn!
>
>And hi Jianfeng, I found you made a similiar patch[1] for the ROCK 5 ITX 
>board to lower down the mmc speed, could you please check if this patch 
>also fixes your issue?

I don't have rock 5 itx near my hand to test, but I have another board
ROCK 5B with similar issue. And after applying the patch from Shawn, this
board can run HS400 mode with max freq 200000000.

I will test on rock 5 itx later when I have chance.

Best regards,
Jianfeng

