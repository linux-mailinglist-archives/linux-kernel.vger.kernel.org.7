Return-Path: <linux-kernel+bounces-875490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD79FC191D2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3CA4234F1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6B132E68C;
	Wed, 29 Oct 2025 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQ4Y24FI"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FC7321448
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726391; cv=none; b=GlJPdgZkRqw53Dr6cmwta8gMRZ6pm7fE9rutfdstvb8u6vv2WHgMkWMk/igEvEbqV4Nd5cEZ4BfzDQaCYgzGG2gH5/xeGArcTS8lcwCUJ7mco+k3cF0PbM+7ASLfdoDHwyIkz82RxxHm88b3lYgCNgXjZ0IXiRxS97Mqkl7KyKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726391; c=relaxed/simple;
	bh=nyCZSmt1D2HnBq6FkYiMqYxTiXGKqyUbzskuCw+9U/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsHUcAFOgNf91mTAF0heTRNDd7cngTo1sygQPQU3oHs7gtDPt8gSuzNIQQVbD775QL7CRXtq6YLKpN8v//9veL/6vJ7zGuOT+DS71GTLdv6ZGm3ULq6ePu/9yZ5zbAL6108HSXv2s9BN+V5mmc4E1VI91V15kkS92RpM/0AO6Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQ4Y24FI; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33b5a3e8ae2so688590a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761726389; x=1762331189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6KBv+9LBo3P3W+l1WrAwkIVp2BK7WV9DO0KdC2+trI=;
        b=gQ4Y24FIrYLGwFP1CDMVDSh9tT495PySd+Uok72QSadHsvG7IYpY4hdt1WbJkoha6V
         c5tCurjgQL8P49tiiO5STDT/l27HuuV+utchBh4iy7K17PXlEe4+O8qacN9j85ZIXmqv
         elvHpm3vTCfocfOBAH0AEGFEXtqbTV0BoX6Ku8eTKozmYTcsLkSz9T5UW+yOeT8t5+Dc
         ZFMZICimSFNLgMEAu8Ee/0POsUjPcAxGuDZdfG4jolDNAtxX9Y7Q1C+RIOHTjNHrMtxE
         NceL4socaw+iUjI1L6m3KiaMKgEp0oXklq0HG1Gd857SiafntseFksH9ibE9jAMT+gFA
         DOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726389; x=1762331189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6KBv+9LBo3P3W+l1WrAwkIVp2BK7WV9DO0KdC2+trI=;
        b=rcBti0Q6NI6x++AoVSLoe77HMq/YxgRG4FSlHITV1X2ahnF4Cs5Iy0LTCkS3XiNIVp
         ZnkSMgY4RqgBWU12R39uToC9X2VzR7V92CBjEdvm35Tj9/dxXjFlwdDSEvNwverScoAn
         6G9FwZeG4TLmemt1z9vwFDCKr7uEcXKUq5gy04i68F6xzt2PTIv9ppGT14F1Sufdf+ob
         NCRDD9bl3l2YPzOlPOaem33gejJ5z28yBz8uhj+4HJGv83Xzy6EqjiTF8FZ+FUUPq+gJ
         B99TFXhYvpC1VThOl7HgIqlVGU6AWgAUQ5U58MTdabxrlr5LPizRw2iGbXtjcA006FnQ
         7Ukw==
X-Gm-Message-State: AOJu0Yym0lg7SczZlre+gSqPM1OkYxELQtEse/2lzmHQiQOs5MgOh8Xr
	0UR61sY4qvxvyd59vZrF4V4Wz6NFsjWGxqZ84C1wdD9dayfTa5BdCvlqYZYE3vaty58=
X-Gm-Gg: ASbGncvgHWuqWt64TdNvLpEseMExqMvCblfeia68RszAiORp3NycEXOuMeHk3/QUmG7
	ulRgHsS8b7FxocmEKBm4dGMmTo1nLUG6qlwqY1sB3H2SViE8JLfmNv1kyG9fGkVJipq2qX23RS3
	u0E3DeWJAYB2ECuSrOjqBB6aQK/GK1IQgMVz5XnZORq6xLgFxZujYjjyvEFd3nb5pkmzg4AobiN
	2k5qeytqa6y155uqeOtrwOO6JlLwZv+95j08FiN4E3iA61lP4oXvE7o4Y4MrMApllev2DbVkPtp
	YuoiI+GsJjK2xZJ4w4PllNfkUyAMkQ0sxgG2ugbPHrb3SqIoxlHWgU5d+P6izNNXfIaLOfmvMMo
	U/fgKo1+6Bsaq+LJCQGHnSTJ2+QrzcCozPr/btMaBq2ui/oIOJL7sDvMTU67aOJDUVp6rmyxmZg
	l7DBEnJb0hhRI=
X-Google-Smtp-Source: AGHT+IFEMctQ1glWsB5FN3W+UH1ALcUxipYIN+xXnYZnB3spEDqZoPtSw+8CX6fNdREkn3EzAPpmnA==
X-Received: by 2002:a17:90b:280b:b0:32b:7d35:a7e6 with SMTP id 98e67ed59e1d1-340396eb178mr2640689a91.18.1761726388553;
        Wed, 29 Oct 2025 01:26:28 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b8087fac6d5sm7538006a12.15.2025.10.29.01.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:26:27 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 3D735420A6BF; Wed, 29 Oct 2025 15:26:19 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next 1/6] Documentation: xfrm_device: Wrap iproute2 snippets in literal code block
Date: Wed, 29 Oct 2025 15:26:09 +0700
Message-ID: <20251029082615.39518-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251029082615.39518-1-bagasdotme@gmail.com>
References: <20251029082615.39518-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1413; i=bagasdotme@gmail.com; h=from:subject; bh=nyCZSmt1D2HnBq6FkYiMqYxTiXGKqyUbzskuCw+9U/Y=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJmM5zVsT2rF9Xw1WfpGmUmQmenQnZeaX84Erus1XZxr+ Xd2xWTljlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEzkZg4jQ1u4S61VnT7Pxy5m ltoXrEuZ8k+oLlo+Y1aO6aMbJ5JthRgZll9oOlV47/2FCIO5gvd+Jp1VLjVaF1Us3eb5Un0ugwM vAwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

iproute2 snippets (ip x) are shown in long-running definition lists
instead. Format them as literal code blocks that do the semantic job
better.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/xfrm_device.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/xfrm_device.rst b/Documentation/networking/xfrm_device.rst
index 122204da0fff69..7a13075b5bf06a 100644
--- a/Documentation/networking/xfrm_device.rst
+++ b/Documentation/networking/xfrm_device.rst
@@ -34,7 +34,7 @@ Right now, there are two types of hardware offload that kernel supports.
 Userland access to the offload is typically through a system such as
 libreswan or KAME/raccoon, but the iproute2 'ip xfrm' command set can
 be handy when experimenting.  An example command might look something
-like this for crypto offload:
+like this for crypto offload::
 
   ip x s add proto esp dst 14.0.0.70 src 14.0.0.52 spi 0x07 mode transport \
      reqid 0x07 replay-window 32 \
@@ -42,7 +42,7 @@ like this for crypto offload:
      sel src 14.0.0.52/24 dst 14.0.0.70/24 proto tcp \
      offload dev eth4 dir in
 
-and for packet offload
+and for packet offload::
 
   ip x s add proto esp dst 14.0.0.70 src 14.0.0.52 spi 0x07 mode transport \
      reqid 0x07 replay-window 32 \
-- 
An old man doll... just what I always wanted! - Clara


