Return-Path: <linux-kernel+bounces-870070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10471C09DB7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 19:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A98FA4EECCC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 17:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523C92FFDDA;
	Sat, 25 Oct 2025 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjDQveDL"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B22D1BC5C
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761411977; cv=none; b=lGv/yaG6w1v/5g/H09MQio5A9Y53/YH8WLhJ/+qZgldmdSu7QNxK1kWky8gcEkoMn9PwGh1LjKej+WusIFY+lwRfkbez+c80W5BHoJONnuRtiC9cbCS/JEboewFK/VhZ2qawwMixPeTPyVSfaHD5by5G5ZjhtzKyGPB6POusqbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761411977; c=relaxed/simple;
	bh=HCu833bmir4M6r9j2JFmyaeqxzTubipvFpWHffKiLvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oREeis2OEhmE++/XHbqKok9NbPM1cyH5MeC4u25Pka2IxDiKWYpHg0kM3qezTSHH+h/v3noSezvMXjQMuF3V/vsHKmkwPk44IH8fo0ZTVEzbFQg41vq/6cEIEUfVa2EgW5t5IqkFw7wZd198M4PjEeAxh9a4Aef9QYih8CN1lkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjDQveDL; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33f9aec69b6so4444916a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 10:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761411975; x=1762016775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O/XY21ztoERrjQmgy/d/a4G/lIjgj5+cHWJnKPaCDzk=;
        b=AjDQveDLIfJJgTDJQeDLkDYfit724a/O2GjiipI+YJZLGD1YDbQa1deN/MmzpZWmxI
         vWwY5WCNGokp3eOFd4CQ+qaSz9VME+pEMtmfhQxe7wJVweKwZCWd7zJqHoDNrL3ab0D5
         /Wqq5p3roJoGWt6lE1veB7GCb1RxOgFQvkuKEVtZiy+69hlX1mkjVS4kUkIO/Cp5lqKZ
         /KocPSbuJWUZPwk2KdvwGChVireimnpgU+d7HjOMmaLMcmMeklSXhGanatz6rHqG4CD7
         s5Ov+YuEYYgDf2NqdejFl4QETWO3aCr69LZsqtiFrdRQ1oNn9Bdud+v667QsFoPGfm+o
         IHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761411975; x=1762016775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/XY21ztoERrjQmgy/d/a4G/lIjgj5+cHWJnKPaCDzk=;
        b=gAPquoca0tUSqRjnjh11ivshQSyNRtK1nxKUu/8/+hFWx/Tgtaw4WHEygyOy0gLXXB
         EkCRZk6qM4UjQoY8pF98AAA9X88WlsqOeZhGIx7sE9fB6g94P2U3zkaq7ZWTY22b/5LI
         jz8my7hwrJj7neEqiwUEcPNuLeXPuvogvt4Kkdk2p0w244sSrRD7IQfSLJP/VP8UmMS7
         xkCehLznXezvSUXGDeLujLUCcyzmAYfzyHHhLfxECZn95I7dC6WrhvLZrgVtKVtTG6RC
         oyXYom4QXJfaL4dS5q49oV2r6vaWBTKR2nT0B+gcmMlDZEsdmZg6OZFq7Xc2XOkI09v2
         SarA==
X-Forwarded-Encrypted: i=1; AJvYcCU4bVtXEemi+D3hZWbv8TAibE8goG5CLxvniTgh+Q960wJhXHJq2UDhxUzQyaGy9cD80oGzTq9N6/TKFkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YycbLGYwcyEeSpIQu1k/F/Lo9jW1kC9sO/XOrMRnEQeNSaTi7+e
	7tkiSMTHuj7ZiJYglHuOB9WerYAG8EfoHiCUVZynBT45b6V7fwflo0Iq
X-Gm-Gg: ASbGncunTmg8R/a9sa+Z05AwntUKvWcO3cZiOYbGkFx3TSpJntKcnK8nxvZSM0BvJon
	yn+nS8ZdXKfMIoeAVcLvZRdX03ziuXYr5jn7SFQvSNaHlk7Vb9gA38oJW60Qm1SzBa26bjAs5X+
	5rwg2JWTv/9UMOnDipXrVff3qrRd/aR5OrYzvWG5quLUsNvX8UlaYIAEl/B8uIhsimgLdNShyX5
	TTSHIHxcblYTdTusuAOH3xAl2GTsOwutgqZEluYW6Z/OMXa3UELFyhnxEeXJAlmkrqXbrsSDRMH
	I0q3FnKaFAQZrmBKkpgQH46Uqocv81HihjNfAGFkvXmU1e0gzcL1yfhVv8SCETbucjjWAfmFUvH
	mpcQ+s4twi+gEdYSVCOKxXkQZAyFqfCLpgiRmaieiYh1HiGmhoDSapQJjrCCOXvwSruecCkdZd6
	Zmb9OpOyWwQ/3x/rgmiw==
X-Google-Smtp-Source: AGHT+IECuaD1uzfsOK3S4QZldR25k4OtDGG1HNwYEOUqeZL32um7yY1qQfcQYZXrA4WJ/IS4Ljj/nQ==
X-Received: by 2002:a17:90b:3911:b0:335:2eef:4ca8 with SMTP id 98e67ed59e1d1-33bcf91b8demr46331970a91.33.1761411974532;
        Sat, 25 Oct 2025 10:06:14 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e70d1sm2857842a91.11.2025.10.25.10.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 10:06:14 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/4] net: dsa: yt921x: Add STP/MST/HSR/LAG support
Date: Sun, 26 Oct 2025 01:05:23 +0800
Message-ID: <20251025170606.1937327-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support for these features was deferred from the initial submission of the
driver.

v1: https://lore.kernel.org/r/20251024033237.1336249-1-mmyangfl@gmail.com
  - use *_ULL bitfield macros for VLAN_CTRL

David Yang (4):
  net: dsa: yt921x: Use *_ULL bitfield macros for VLAN_CTRL
  net: dsa: yt921x: Add STP/MST support
  net: dsa: yt921x: Add HSR offloading support
  net: dsa: yt921x: Add LAG offloading support

 drivers/net/dsa/yt921x.c | 324 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h |  55 +++++--
 net/dsa/tag_yt921x.c     |   4 +
 3 files changed, 370 insertions(+), 13 deletions(-)

-- 
2.51.0


