Return-Path: <linux-kernel+bounces-880499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B00C25E73
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D0CC4E6E74
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ACA2E8E0B;
	Fri, 31 Oct 2025 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nW1y1hBy"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EF12E8894
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761925975; cv=none; b=bo4jXGp8EU6JZxwnkvalDXsTsUEAZFOzxxr7FYJ3TzQZLZVsBUWKuq/E3GaskutKTOsysWlGaOxSwE8JbleHdmEFo/t6xk+PSMyZVZgMjx5jEPlT8St9jZHbWkYLp6WBtP5jevboqoJ3eA8hIGabxwObzgETkzHOql2w5XbOPx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761925975; c=relaxed/simple;
	bh=ywuqBEwRpRScnW+bb5t/i7Wkw4UY4DDO5j+kmL9KXEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNdgNpH8CSN8bSbMiLk20s1LV6VS3ZtmE2ySjPq5fZ7Hk6mrskNXLrfSD8QsV/tmfa8Iz7a4VOinWUaISLe7C28uAwV6i2pt2Uj6CYkZ6rmDlZjqSrwpNwZHea4HIHrVNcb/GyQ7RFo7/j8D3fVU3pw5pfB87Ufvu5LSBzk6KJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nW1y1hBy; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7a270fa24acso387004b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761925973; x=1762530773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywuqBEwRpRScnW+bb5t/i7Wkw4UY4DDO5j+kmL9KXEA=;
        b=nW1y1hByCT2EIHH9AV+P7YhFHTr16flibe7lFxEPZjFF9sEM4YK4IDxKBWBnHv0fBn
         C7qDsWCFMzwaY7srB3BrDeORL8mX12cCxp1cYQtoK3xRyMoq8n2RcLYpE8A0/qDMGXxo
         7FKc+nTuS1tYiUm1w6aX3Dj9xBTIgPyb8NowM4OXBz24OdtifEewA+3pa3OYpjc2Rn68
         9zdirdZhsBFkWXcFdA9TXj9AoHa/ZLBR2wbzupP3C3l6tA/Jmzxx8U5j1eflmkcHz5W+
         cQGj1Jh/W58vQnoiwEbgaqF2C+wdYZsqOQ+Jt879P7eY6pEPDSsgII76tqdys9+4a7DL
         tOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761925973; x=1762530773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywuqBEwRpRScnW+bb5t/i7Wkw4UY4DDO5j+kmL9KXEA=;
        b=APJscp8gokyvuUJCszjsGkJImy5Xc2DlXyK6Wym1dyFrIajydzKCSWriub3GbT9oyH
         YREjYBHGEDY7PixlrBoapSpVEHwqk2nIplbEswqQ2TNDB8fIdL8uWVcLAKE1BkoABbnj
         XW6nIcSUa9clivyoZQo0PmklIdpuoy0QzPdWCF5/M31o5tqBYsa1cnfRXaUOs2HS5K8n
         Hf9jyjk2GkrTh2GzRhkGG2PetToBDUlnzaVjgd/Lc0rbXKK05LrVxZcxZt2WTX4oqWhl
         vR+48sTb2u5vA00Lr3Kwsp1E/cQ0X5soE0DYzIhQBldpKRKLh/Bknreg7KsskltteQL9
         brXw==
X-Forwarded-Encrypted: i=1; AJvYcCUCbHfKH0+Icy95h+b9/HWdr70g3LsW11bcqzie7S7Kdh8rTaqQk3MhfNuygCzzX0TzylcqhICdBQIHXxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw2Kvtw8F96qxoqvMplx9hzs7ElHz1RSesM9XygVT3B0a/3m9e
	LnW1HqGfebZlwrAptO3hHQ768G9GvlqA0bSqrzdZwfIL0CfwCIkgwiqg
X-Gm-Gg: ASbGnctmlkx4kJx41wqXbBY24dNQsJd9dNUYUG7NQDhhPSdEcSIFV0SNleY+HST/Szs
	+M33THbWF19FzupJA7JKhphEuX025PZq+qTil3julYQlYIsR3VIbnuFakh1ZLwMaxL0o51gpueR
	D1I9cTpow0bZTIeATF4tnZSOheEHMNaJoAih6Q4SYvEgLHuq44WDeAgAQ5HKCrMNu05KvEW+yH0
	qBEA9ziby1NsnzVFubTEvbQg4UbC5M4L6TdQKWx/kMgs87uumK8XRnAiFe4oR2e8lp4+ZXrlbXJ
	zN64xv+bDAPrPdvaOajJr7H8jiq1YaqixXxGxV5jE04zvVSYmZKXn3Hw2Dvn5/LGDXnWCYVUsMY
	ma7NGcYqQZ6gUd15F5EFpXvRWABtfGXKgXq3bJe3SNygI/c1JTQNYgeyJZ5etZzGBsHRjl17P0A
	8Qt5cvIYtR4Q9QaR0nnzsCZCQz80A3a8EOrVwrmWQBWjIRKqTD5LOl
X-Google-Smtp-Source: AGHT+IHBQBstMXUUtNmpXOsCsPligClTf1NIDDX9ASsY0non7XP6tWdlMRv0kdvynqZ8iRRCPz8/Yw==
X-Received: by 2002:a05:6a00:1946:b0:781:1f5e:8bc4 with SMTP id d2e1a72fcca58-7a7796c3cf8mr2650391b3a.6.1761925973162;
        Fri, 31 Oct 2025 08:52:53 -0700 (PDT)
Received: from ranganath.. ([2406:7400:10c:5702:8dcc:c993:b9bb:4994])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db0a019csm2608577b3a.42.2025.10.31.08.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 08:52:52 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
To: edumazet@google.com
Cc: davem@davemloft.net,
	david.hunter.linux@gmail.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	khalid@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	skhan@linuxfoundation.org,
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com,
	vnranganath.20@gmail.com,
	xiyou.wangcong@gmail.com
Subject: Re: [PATCH] net: sctp: fix KMSAN uninit-value in sctp_inq_pop
Date: Fri, 31 Oct 2025 21:22:33 +0530
Message-ID: <20251031155233.449568-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANn89iJL3upMfHB+DsuS8Ux06fM36dbHeaU5xof5-T+Fe80tFg@mail.gmail.com>
References: <CANn89iJL3upMfHB+DsuS8Ux06fM36dbHeaU5xof5-T+Fe80tFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xin,

Thank you for the feedback and response to the patch.
I would like to know that above analysis is valid or not.
And do you want me to test this suggestion with the syzbot?

regards,
Ranganath

