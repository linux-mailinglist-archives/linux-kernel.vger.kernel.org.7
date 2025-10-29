Return-Path: <linux-kernel+bounces-874994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 853BBC17F6A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1464E4E708F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653712E1EE1;
	Wed, 29 Oct 2025 02:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYEqokpC"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFE82DAFAB
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761703200; cv=none; b=ISl4ScsffPusJQUC2t9NJj28TGOqo70BxFqzOuTQSdFKETyDTyQf1VAy2TgSa29lY9kOld86UPQ7/BN1qMVzBHjmitq3EgzLYh0AiYilaBbkRm2LOAuGUpTbx2HjkUoVWnxM5C6XQCjDttCNfv2//rUre04BX9Ec/VOYTEtOIO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761703200; c=relaxed/simple;
	bh=hP8eF0K4Fnew1ZKu7xTTUKH7Tg+SmdBmlL5J3VUiePw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NMW0mEnBnNJu+9Nz2swBo+IMnueOVjAMoXQaletXZIkA4CvYidXAb/HYTw7PX9CJf/my8G3wLrnKh3ynhSOLu5eZiYtX1f1Gmv49BpIm3qumXJR5HETofVVx8k/y2oT+dSb9K41sCrQPliuFPa6WnDHAi29hRRQqgd4ZdUUmNpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYEqokpC; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-269af38418aso74235925ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761703199; x=1762307999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gfqaQ+uC7bdG4ILE549OVeYT25uPWQdC6S7HhQE7unI=;
        b=BYEqokpCBsHmtejJeGUUev3w4G2PKT4TwDvORE6nxjSHaAIbyTLgVNkyBuNEZxQo1g
         y8Zgzg82TE7OOepAHXgTHjAEdOa4ypPcM+jYW4Zc/qmhP6Rtwr/J7q774IOMYYe7lJjD
         389zWAtpNb4n/ioo1xgK0liZMwMMHCYzfM+C6qVdPokRientoMBCQqqR5ErpxKAvgBSK
         Fpfbi4AocSyGTjr94ukXQvhZzM+AIm1ok+HrpYg3Skq8RcizUCCiqtCiTDqWQL9iByxj
         mXyM8sOUJiC4EHHhX983FH/176GdiP96W60sIZN9GbpmNFyoG9woVf89bCmoJlUHIoE+
         lZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761703199; x=1762307999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gfqaQ+uC7bdG4ILE549OVeYT25uPWQdC6S7HhQE7unI=;
        b=WRFi4S65TTdwS/Icbumj6B5atiadUr35T10ZOpGgLzKnsOlmHhqvfUXDHyO60lqVX0
         gFXMbHP84VOT+JJyVsXqKpvi2baoQSWQPFsWdtT6LHqtK5KL4VCzGYX5CMeCw8kYu3bR
         MGMTIQrrrDvpdF5HKDQR7xfPwPtn+aLiXpZqv44wUU2AJLnyBVCBdvxXExbB21JKUvC+
         98P/zWLn4mjp8FTOe/DhZaRtEqARh4pMo71Rdt5h7vCkGKF3qADlHgdMsEYLxhH9flw3
         8jLiH9sVHDuRKCAAYmQLhSHQo0gjrbx5OUXWl1J/YlnKa8ow6JbJE/spSYOxKVxbnPgY
         MurA==
X-Gm-Message-State: AOJu0Yw1OUc0pYLquRAydwx3itlupO2R4jrWdWOebGFUfg1185w/AfPs
	UXh9hm6yB3mDUDC2zzv9IRy2j2cPe6QONmJHcUt6QEinIOs4+/ijIjVm
X-Gm-Gg: ASbGnctKCySCOQoGlyVhql78mO3tQbiqCoD+5M0A2NRy8fdmSWukIv+sHYexyFpXxte
	q3kHWx1SySbbTLWvOo7p6j80mgc+UVt5UUIt1ulqkLjMrltHaXlvgwcDs2IAiiykmzM9k9voP0u
	I5NBH2ufXbTVsjh6bJ6fGIxV624nQ7b2wTURTIIQ4S/lzvNhCSfu8n95I/toLT2DYdW0g2mCJnV
	XOj0jERK+wugADoOFa9FOPmTH+aatir9aL+7HBiyY3h5RvrE3TdXO5Tkrd3FnvSMEEvTAbl2Tgf
	gM2p6l10ATQ+QjIgvMF+74s3OrEEKopzycuP+9wenJRdU/Hq8y0iEQHLiZXbw3e2ojRE/0ts0zO
	1vgIiYek2RnGqoCut0DIiIjXa9ux7Wq/ITS/ehlHV17FbTf7y/FloWwAPbm/TrsTMCnDv8ip/px
	rJaDpPEtXdF5E=
X-Google-Smtp-Source: AGHT+IFlhaFEy5i7fb+WJyyvynWY8Siu4ggFFXY3WiOcoLFv8mNx7LPXoJr5hXn1kPXaKhQcEU3+vQ==
X-Received: by 2002:a17:902:dac8:b0:290:c94b:8381 with SMTP id d9443c01a7336-294dedd419emr16660645ad.7.1761703198547;
        Tue, 28 Oct 2025 18:59:58 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41403fa75sm13177538b3a.28.2025.10.28.18.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 18:59:57 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id CED3F4206925; Wed, 29 Oct 2025 08:59:47 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Breno Leitao <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next] Doucmentation: netconsole: Separate literal code blocks for full netcat command name versions
Date: Wed, 29 Oct 2025 08:59:40 +0700
Message-ID: <20251029015940.10350-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=865; i=bagasdotme@gmail.com; h=from:subject; bh=hP8eF0K4Fnew1ZKu7xTTUKH7Tg+SmdBmlL5J3VUiePw=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJmMJVKXNp3r85oX7K8e5aYyNynwSkWpxenE3JLd3R5fN ryO13LoKGVhEONikBVTZJmUyNd0epeRyIX2tY4wc1iZQIYwcHEKwEQkORgZHnKHpSvqlLE9y83a 8WfdhcUsXgFb+ptNtvq4bli0qqjLn5FhWa54mShDdGOaW7fsfJOs4jAWu22fdU8+s5ojnf/pphM TAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Both full and short (abbreviated) command name versions of netcat
example are combined in single literal code block due to 'or::'
paragraph being indented. Unindent it to separate the versions.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/netconsole.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index 59cb9982afe60a..0816ce64dcfd68 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -91,7 +91,7 @@ for example:
 
 	nc -u -l -p <port>' / 'nc -u -l <port>
 
-    or::
+   or::
 
 	netcat -u -l -p <port>' / 'netcat -u -l <port>
 

base-commit: 61958b33ef0bab1c1874c933cd3910f495526782
-- 
An old man doll... just what I always wanted! - Clara


