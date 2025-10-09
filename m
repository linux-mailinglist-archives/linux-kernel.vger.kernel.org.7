Return-Path: <linux-kernel+bounces-846292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B724BC77BA
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 08:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00DF03E6B6C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 06:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9429C295DBD;
	Thu,  9 Oct 2025 06:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZLsK/AW"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD4625D53C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 06:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759989843; cv=none; b=d9z+WzlX/HMn1zfsQ84g4SEV0xCXmOBfJcLFQeuMFlYrLOXSGOrnkjL+vNFxiRkFv4WZQTXYphwlHiVQoToIX5aNCrpVOLK+amAwicNLYq/zd5hhXoU4XqIPIIjobhoPFyg5O4OpbZP9HEMfNglWB9btNipMf9yNYqwtqVUq3mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759989843; c=relaxed/simple;
	bh=oIgR9ryeL/hgU2Ls/yixZK50PZdiBg1+IVAuWVPt7eA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fUpEKDsY+81/zisU+ljvKZzgFSH4Vz2Avm8g99fBec7yIcu3rB/k1xQBLbIox4rh0zFct0PyqG9Th97MJne/AJMZClsO9c6x40Qyhu6q9I/TDNy/Yz1ag4QdO18lxu/MDzrzXRMTJ0tTkbebUMiTQF7qdjRFnwB/lP7bAFCbVXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZLsK/AW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-28e8c5d64d8so5311385ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 23:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759989841; x=1760594641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sBcTUhKsBJuN6HOBlbpiv3saKcS96LDQWFTGigREUFE=;
        b=RZLsK/AW5bfgHKjgmBFWvJRkNrhAr1uRFWoWGtax0raKkHSamNtI0QxlCW8mRC9OZy
         axHFl7IeI4Hrfa+NPtgIW8+zktsiAG6NMGgMAputt2UGmAjU5l94lOkqeINX1/v6VYrL
         eQR68PRghvqS4s5slQhVU6xGmheV4lXEa3/7eJLccSpeYtLod8hRGxVkztcDx/OGUqsy
         lDql8oZXl9Gof02JLwYARi6gXv4PBT6oKFjPO5obPW6GrsXG/TxukSFD9B+CRrGDmDdH
         mQyKZcKTr3lrPihTbBYPFN8ImSz1KBnUDJNFd72JQMqPtqsiG4io4F+oK2PTJS0Mxrp/
         7C3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759989841; x=1760594641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sBcTUhKsBJuN6HOBlbpiv3saKcS96LDQWFTGigREUFE=;
        b=KxrgB33mm68HsECmCo1bCHyW5sBZo2KrSzONYAOGxy+dzciPes6zFia+dXJ9tZ7lcr
         FnKPiSctyZGM3IitAHOmybDnvsj9Dl2yBAvF/ZFy1jD5c+Jf6RKaAQnI9v8oRzBSH3qf
         XnHKUXd3drEMRlsnWhJmSw7XVKY/9t6mbH0kk1yYyhASZXpQnYGRNqlxjA+rvX/wdjql
         DKtx5TDV97wIJCe0UN9hBkRM2rrjpLyV3Uffy92VIGIxdTnMKcbbJeNYQr6Bg6xE2zW/
         fiiTzYsKK/aOVrjfViOSuly0zuatTeAqiXTBu3Kl5IBcepIZIaCT1lVmaTaU7l+BAFqv
         0IEw==
X-Forwarded-Encrypted: i=1; AJvYcCWgJxcM5D5E4VJA+oY6b3nVP7+L6W2f95/d973kL/7g7QmtVGZhRPrVCaHds9BzHS7Cf+LwkackvKopM0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx06e04CmDN2Xc6ErUiIRyyjyWzOYexjlZZkhEeNaiU/IV7/YT1
	W4bwQDe8n8NZCw093Sik/AEL/oNYUYXB9vWw1LQXVApw1XSsUWRBh5+U
X-Gm-Gg: ASbGnctN/sb2RySnu6ifo0gWy0Zwa1NakmzRF5zgRn+ks8tkX4onP3IJvYvfMcuHZKg
	su5+EcN5TxI3GqnrKbaH9zIFdXHU7rO2exlUPTe7DAcx9NNcqjY1Df2ah/p1pAl6a8iC5qNX/D7
	GTwUsj1wRXwzlUPKbRBAuYIwvsgDbnfkB3d7f4IEPh2eXRGArrhkP3UeTvj3V13lwly2ILLPG5o
	8SlRPvm0HkYn2FivBhFT241iA7u99Bb+hodZEHn4Sa9qqQ52phjf2RoPZkZJiY31xuEFEp3IpND
	1HZh6Uf1VWFHxLiWEd9qfnjIq9UWYWQVarTkringNbAFCIMwN6bZaJjpEhBCG4/XjtD0aiqhUtA
	iNgoocBRIgktihai6UEI1Jmj7ir37ouGzeKyHyhzIIw==
X-Google-Smtp-Source: AGHT+IE4tM9PfDiOFb70h43Kpvl4/9t6W1zFjvmkTzJeIu73kO8m6cPgSu4+3UGkTE+MU1d2vLlIow==
X-Received: by 2002:a17:902:f64d:b0:26c:e270:6dad with SMTP id d9443c01a7336-2902741e4a0mr65888565ad.60.1759989840498;
        Wed, 08 Oct 2025 23:04:00 -0700 (PDT)
Received: from localhost ([46.232.121.212])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e45568sm16388955ad.55.2025.10.08.23.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 23:03:59 -0700 (PDT)
From: Frank Cen <focksor@gmail.com>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	Frank Cen <focksor@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] docs/zh_CN: Add trace debugging Chinese translation
Date: Thu,  9 Oct 2025 14:03:17 +0800
Message-ID: <cover.1759988849.git.focksor@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix RST title underline characters for proper formatting

Frank Cen (1):
  docs/zh_CN: Add trace debugging Chinese translation

 .../translations/zh_CN/trace/debugging.rst    | 133 ++++++++++++++++++
 1 file changed, 133 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/trace/debugging.rst

-- 
2.43.0


