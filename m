Return-Path: <linux-kernel+bounces-822744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A6EB84926
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D774A84EF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4082FBDFD;
	Thu, 18 Sep 2025 12:26:07 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF8A2FB09E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758198367; cv=none; b=WRUXCrme3D8FbwPU+ouKdBHkQYdVr3lDP/yYqYcivr41879OhY0idRWUXesi5FLMVFl1ORzzPA9tekhfG2oOQ+DNNqIjpY5Vj5ly9IhSaTuHm3rVMEiUN5JfWFy3A+D8VjFpIukch3XaW5GxcICgLjLItSkUknJKMPpNtJ/AMo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758198367; c=relaxed/simple;
	bh=BnrMrtsr2AwzNeynM+FwYe/VSFvzmFKnora+bM4/LaM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Gn980O0BGPattdNmNwGAp5z09tcIKnyTh//VWSfGrU6IZtTKMnftidB7WOZuLG4SsBX/PWewqwAwcgN/XdTw75j98P4RpqCSrR5rjdY7aLbu7FK7DJif3CB13zT3fQNO+o8njnZymdWXQYMGbjwxEQGlU9tyto2xfGJQ6ZZ2/gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b0418f6fc27so148173566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758198364; x=1758803164;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tb5jY5fs5C8DqAcfkDVhoy1uAvDHAU63YQhZVIzsa1c=;
        b=LojSxdrVuenbAQCtrw0a/PGEAlktqxVFbx7U2LEaD14pmRzGmLnESkE429CRH3nUaH
         V+7893g+thTKp9ML6gWSVOCNDTSUP/sJ0TBqf6IN8Up0d1FTRhu12eUKWw9W2yLE2Cep
         wWPwPjxu0k4YAGtJN4Y/Pc9ctySysFH2rWGvWCYy/nLM+kwBrfCEagUEDzJBtIY8mqUX
         Zhg0H8kXWjDd+nKWLAslhCicmlXX3sGao2/5/z/Ty34XfKLoDrHOgb01C35oMxAoyQnL
         WoYp4hR+7Unm8CekeTSkrD6BXvRYzBuqQlPVhCyUV8H2sLuSC9QGM+YMz+vLYnP88481
         qcVA==
X-Forwarded-Encrypted: i=1; AJvYcCVrKMUv98LUQvg+LzZgV/DjtWO3ngvICxqBUv/iR+BSN0wf2rIQ8MHgPiMIxBrnaIMhToTpjdNhLcepMFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YymrVqgS4lEc0jyaSldeGSKx63T63wOgluWvx1K3GneOnNaPAhc
	0VTQ5+FxtmJWlLs+gwTdtHxrhxqZN5MaPzOJMmZFWikM0F0B16k8r6lR
X-Gm-Gg: ASbGncuPs0NL0xpWbCzDiQGGMZfKmwqpJTSVadMQ1oI20DpqgiK1mexe6pYkIHISRY1
	uraW5UPm9gFhVVlsPkkGowoHZR3cJ7hOU6xXLcULNH2Ve4EA0gtbmnmErT6yNaJszC8pdEHSm07
	FxWYvHMZAGZpVuScr+7WMJsKMddmNKre4NIj1ITGNdU7tzTFSHN38LvJr4q2zw+dd9516iI5+Bc
	vmv4bpW+zmgskO84+IfTKJw2Y/DnZMFf9gqUwqWMidbVIR0G6UAsOBs2+r74yrUPlawEZX0sGP5
	SBcCVywlkOv789gujTwxX4MHa81Z4yCzxT781rbzD7X2aMsuUmFVAsEeJSTYL2PwT4rl8ax9td6
	lEa13a+0Bc68y31KjHj17YENySB97jik3
X-Google-Smtp-Source: AGHT+IGEfoHakw2xql8ZehfjfPaOLhWCCVd10JLLYxDRAxbcr0o84RQ34UJ57G2Uqs7u2S8lio3MaA==
X-Received: by 2002:a17:907:2d0f:b0:afe:764d:6b22 with SMTP id a640c23a62f3a-b1bb50c4172mr608468566b.9.1758198363665;
        Thu, 18 Sep 2025 05:26:03 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:44::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc73ba6c0sm187053166b.24.2025.09.18.05.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 05:26:03 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/2] net: netpoll: remove dead code and speed up
 rtnl-locked region
Date: Thu, 18 Sep 2025 05:25:56 -0700
Message-Id: <20250918-netpoll_jv-v1-0-67d50eeb2c26@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFT6y2gC/x3MUQqDMBAFwKss79tAtCqaq4iUWjftiqySBBFC7
 l7oHGAyIgfhCEcZgS+Jcigc1RXh/X3ph42scITGNp0d68Eop/PY9+d2mXHxve9b6x92QEU4A3u
 5/9kE5WSU74S5lB8mS6bBZgAAAA==
X-Change-ID: 20250918-netpoll_jv-9bf6f640f308
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, efault@gmx.de, jv@jvosburgh.net, 
 kernel-team@meta.com, calvin@wbinvd.org
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1370; i=leitao@debian.org;
 h=from:subject:message-id; bh=BnrMrtsr2AwzNeynM+FwYe/VSFvzmFKnora+bM4/LaM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoy/paOttH6yMEPbyggzhbIa4szrf811dI+6EWz
 bNb4Neq3AiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMv6WgAKCRA1o5Of/Hh3
 bQaFD/0TW68QYyYiEtNVxKw5NsP5fz7z7VNSRNZT8Jvwg1rpeuAH9WhzkGyAy7V7h4Wlr3umEAU
 O7/1hnRmDEHTaePy7MuIYWKOVWq7rFTfW8aX5FYVDmB/mpqTs0uh1S6gxXidKW1vfqv/q5zfV9S
 1XtB0hyuLq+4PyZI503bfVan3lNpgqlfeRCNP+r519FU82XipJKjdhjO+hMxG/XPZw0Sz1bryqv
 fIDnuh0toMlrgilg0dRlJ6GALvzTIEPnqcgiacYBrzmiTHlcraoULnynitBERD8rEyVchgdT9fZ
 yPYmdDgl6oQO7yWDONKqPfijjsbAG+HFtk9agdHjVAMvvldXYQ0xRRCfqL4LmZaa6OaN5s2C7E8
 6QnlemA3YHpopUvTA/WExxTowzBn2DFAWYvNrgqqQFgQ6LxAoFZUR25aazVcEYTDSHJJka0Waen
 J8tu/P+7eziRCFkFwaHqAZRkadX5MsN4hODQYno0kYQrbYW2YFHb4JKUfZWTda1sJjuH5GKgF6Q
 Y+bjTcU7r+6OVSRcuT6mw983Nigcn7tmuOj94bWvIP4kpKyyuXZRwffVEVbhqKp5vOtRQSAVhGD
 cm+IX/IN3mFee+B5KiMa1lR6y9XqjQpbqypKgU/nXabmRrRO+Ubt78Bsgk1F/6s7msQRPHRsuXZ
 /oZTBHnjD5nactg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This patchset introduces two minor modernizations to the netpoll
infrastructure:

The first patch removes the unused netpoll pointer from the netpoll_info
structure. This member is redundant and its presence does not benefit
multi-instance setups, as reported by Jay Vosburgh. Eliminating it cleans up
the structure and removes unnecessary code.

The second patch updates the netpoll resource cleanup routine to use
synchronize_net() instead of synchronize_rcu(). As __netpoll_free() is always
called under the RTNL lock, using synchronize_net() leverages the more
efficient synchronize_rcu_expedited() in these contexts, reducing time spent in
critical sections and improving performance.

Both changes simplify maintenance and enhance efficiency without altering
netpoll behavior.

This is not expected to conflict with the other netpoll fix into `net`.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (2):
      net: netpoll: remove unused netpoll pointer from netpoll_info
      net: netpoll: use synchronize_net() instead of synchronize_rcu()

 include/linux/netpoll.h | 1 -
 net/core/netpoll.c      | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)
---
base-commit: 64d2616972b77506731fa0122d3c48cb04dbe21b
change-id: 20250918-netpoll_jv-9bf6f640f308

Best regards,
--  
Breno Leitao <leitao@debian.org>


