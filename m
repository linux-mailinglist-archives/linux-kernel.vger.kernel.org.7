Return-Path: <linux-kernel+bounces-887182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3151CC37783
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 20:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D41BB34E975
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 19:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF06D30F81F;
	Wed,  5 Nov 2025 19:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/oKO4TE"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB97268688
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762370795; cv=none; b=ngBiflyDfnLRwWWbIRdoKlsSxewK3NqGyH9DxQNtnJlv4mSW8IPdcV1Np1cJf2LmV2wzXnYbMi1uh3hIuYBDQDTvBjPhpl1j7hG5GyV0ZKsxiippjrdkndFWtXtqGcvzvDktHSRuQlkD6fLw6xLQh3eIy972WCSiAeGvf+Nwx0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762370795; c=relaxed/simple;
	bh=UNZcMpuO6y4OJjn0NtIVuErY1p4zM2D4jXthLsi6Mpc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Z7Cn95yXL9kl6TLSPR3v0tl+1NTZF5cFx6wS5n+uM9GbuQimzo/ghg8DzS1mavEI6DOqxQDnC4yC/D5UFgQTyhNpGoLMt0l1CXaKiyOeN9NMicc2padHTrwgm2Bty42GV2qlNv0CIWxaBKJvk4uc7dhTH1qBiU5G5AJdzJI/eIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/oKO4TE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29558061c68so2532015ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 11:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762370793; x=1762975593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBGVBhk9WiBBQIyOs7VH474iefDJjtxM86Nb1wbwzEQ=;
        b=M/oKO4TEOceSmtEHilWCfNEnHYUL72a35otsYwZ0y+JNmn5ojJjz1Ftx9/sCOHVW20
         PQunOCa81Gjb7i6mB3j5Z8WQkJJbYFGKjItZJz3lJvFhOQq3vNc6Ew8sesA6xnTkyTTc
         x8tFDKnYBCh/7Px7FwvBXZ8Qpc/mu36XMGD8WcqUPdpmyaOXAgV+Cs5hkXkTK0MQt+2d
         zFQL5Fi7abKWq5dxvfEkZLoT8+NjUB35DuNjFzV7C0LE3JJk9ySZ5Xw3RFSmuCTknqNy
         lfcbK9yZnYPO1Nhg/IAt869aPF3TCB4j85OQpb3sXmtdFowoAgU9DK4DMQw2jLFdh0I+
         B1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762370793; x=1762975593;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eBGVBhk9WiBBQIyOs7VH474iefDJjtxM86Nb1wbwzEQ=;
        b=W4UQrcQqVTJqgNDp5YPRQDiskJbheN788QkXqkGTWHWscN1tIgXPAE1ImGwkgP33aw
         mmVn5IPkeuUZ01lF7UFWF7ub30cXz/03qd8FF+3ERsM9Mptyb1bQ34Iq37sP/LES2D2J
         /2vJ6T9yuwIeBMDd4FaRsCyxhhrkosfF7EXkb8Cydn/952RMpaktSgioS+HFLxyD/ujr
         BpXH6u2YOEL1HixKnhxI3VxofGRb88wREp7YEtf4IwTwx90nMaGwGF3Dq+Gf7w4nMXK+
         9KxLJuFhp6i6lNxCHyOkigorsY8kQZJdH3sRDv9gXra6+x4qp4ZOi4p3L+u6JRyMewtn
         PTmw==
X-Forwarded-Encrypted: i=1; AJvYcCUzY5KB4sVnz7IeGXRC24EnjD0l4JZhmTFCQOO7AKx12NGP+Em8WFQkng0CI6nH2vZNixj2R0JKT+CK/Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfBKx7CznoKDKsmxbiE5Xt94FKOFQTsm0QfzCK3bGtFlSbmRow
	yVanxU2vZKXd08g+Zz0IUMbbmS0Tz7DqDTE6mmBj38DVKUvwVUG1u8+X
X-Gm-Gg: ASbGncuFRu8IsDrIOKHqI3yeyfCZp+vLN3YD93ob5RaPTmgyANJU4Zk9xB/mssmXlEv
	fbJbEIE6GtlTTn//OO79kd9sX5QKOa3ElvAEOTNjNokjCwhyQTzpN64w8z/8BIt7jUT7IOeDUG2
	8LrTXH393ZDueZia9E6AXt4NtQlo1Qd8kASRenL5prSEuaNrsqTVSapZRDRv09/fRM+IeZYs++r
	+n9sRt3NA3AbcODhsIZTbeVIWwg4Ir85znn3WS/LUo19pg2nFTonLN6apP0+H1cTtLTuTNHlzzQ
	WRMcM04bY1XIKfguNsMJNDqejE7h+E6CvqUB909Q8b7vPg6kmCwqDzt4KyfegrQ1mpJoa5dyUx9
	/PWpco+LWUZLwbegETVUJ4CxdF7SYvce5a5KQtlJMRq7LE35KUYumHYjaGlPDiRxUzFjJU+Xv03
	9oohqvHw==
X-Google-Smtp-Source: AGHT+IHdphld0nTUW0FL4kZnPuqWZOJ2nTOf3UbOG8vdAxizKHLsONTbcVoz1FMjfjVAQMg5mnXZhQ==
X-Received: by 2002:a17:902:f68f:b0:294:7048:643 with SMTP id d9443c01a7336-2962ad1efa5mr64435405ad.15.1762370792924;
        Wed, 05 Nov 2025 11:26:32 -0800 (PST)
Received: from [192.168.1.13] ([110.226.177.99])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8ffd3f6easm102870a12.21.2025.11.05.11.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 11:26:32 -0800 (PST)
Message-ID: <8a4ec353-fe9d-4c7e-a56e-796280dc7f47@gmail.com>
Date: Thu, 6 Nov 2025 00:56:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com
References: <5ff5d1d0-192d-4aaa-8ef4-e1bfe2fdf6bb@ee.vjti.ac.in>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix use-after-free in
 l2cap_unregister_user
Content-Language: en-US
From: shaurya <ssranevjti@gmail.com>
In-Reply-To: <5ff5d1d0-192d-4aaa-8ef4-e1bfe2fdf6bb@ee.vjti.ac.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test: 
git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
https://lore.kernel.org/all/20251105142251.101852-1-ssranevjti@gmail.com/T/


