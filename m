Return-Path: <linux-kernel+bounces-740728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA07B0D85A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75FE561D59
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83C02E3B09;
	Tue, 22 Jul 2025 11:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ij0VPQbQ"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8032E040A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184228; cv=none; b=hv2DZ560qqRWqWdVA+Nn7M40hTEzZqL4FjRH2eyc5AARd6ks4/b82aQ1R5Y8kp6M64lI9MqYaIZR//54WaDX3KqTe381hihe55tDYaRMpr2cdX7pv6qYJQZNPYBpHxD8h+TNOpXNiAHSJ+1uKjFj++vTrXj3NM7tduuGDa22mGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184228; c=relaxed/simple;
	bh=zKN7GZBUOoF68h7KJIWOozCH19bbGuE1GwHKdynf9Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bpl/os5JAmD/M98DN3RCMyk4EhE4dnqStXbaA9V0hlisN79hKsPjq1PqWLN0zpVerw2DbaU6XQkweTOuUk22FgiId5rv3MLtq0apHAp2x2qJg3n7Nl5VGOjZi/zV2qicCiW2/wuQNQHSiXjn1jDjZ7vnmGFotcQZI4Xp08QvieY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ij0VPQbQ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4abac5b1f28so47627241cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753184226; x=1753789026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKN7GZBUOoF68h7KJIWOozCH19bbGuE1GwHKdynf9Rk=;
        b=Ij0VPQbQECpaFx/B0Hvnb9DoEPrlfbaSAVfOmXbt36Gul74P05cjT1LqxT9Asl6l8n
         iuyJH0P6ECef1RdwjwNLyZfvPol9FMurIik5eFitEOeHynSITU9RPTd39ofXERLVh4Lp
         VjqStmOX9UGMoVCiAhULEX6NKrshiUmSaTCwH9y8ABOdqeeX/Pi74/O2ZYH8kH+Pvgqk
         TnDkq5EGqlGIZDEYc7An7NVRLMKYSa1o52EDeWGyZtb5I5Rb8UqFD66ZQ2iT/tRxktWo
         MldraF9v0Xpt0AvIpL9tyNHlzlkje1W4WGsGvSBDfP153JTwSGrRtMyoYYZGwbCU3Kqs
         /SYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753184226; x=1753789026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKN7GZBUOoF68h7KJIWOozCH19bbGuE1GwHKdynf9Rk=;
        b=iaflEeCIYsd8fggcgrmYwJDD8gkUz2G1gHQDDnMaEnOYEk1iuaY4uMEKtH2dJ9gBjx
         ufyuQH6UfYUQhz3SQFFzAjlxQw+W0XMmq3VARIqbOd84SGFEcn+NvPoMr2mh385JTmAa
         zdDYflNTpw0pOO8NgxfY7ehENC35lMp5pqOetLm4uNe0TXy3OXqflcxm7hGRTReII0+t
         Ur73h421qebHaiat/W1xA0bfjLkVbVay306n9KxIypWlhJv1iLjmX1hLhQdNQbuRB/Q4
         A2lzVgbpyuuEGwrwFaoyyYhnoWXiTBvqH79jsJAgYGAIn8so/aiAScrb0tsyrPwoIqbS
         SWgA==
X-Forwarded-Encrypted: i=1; AJvYcCUwE7wWYYOGthR9De41u65s+9gjZSy8S/7q0fvju5glSoyC/QNicG4IGW6J0V/YnKXaN3cwDLfFYFFOq9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNv9cfAkn1hfeHp8ql+lpfIQwlrmFwOaWuMXHHCv4a9KQ/vqGB
	IoQQNsdHH8VNBCe+XQh8lu8bq7jtvZiWX4IUDZ0d1qNgCY32Plmu8Rrl
X-Gm-Gg: ASbGnct3jNLODpkTcXd5fs/jI+roOemHRgp1Tnex1TxjoNMiX7RXGtOML8Lb4k/3mYD
	JaK+FaOyqS9dBPyNQ4byp6L4UGszOvYXtuJYTL3l0HuG3qByeS0AgXxf4lq+1cOoCqSjTuTxMUE
	E8fnL4BeegZ+t0jZLzDC8HFJrXHCmHgn3KGP0I8Ba/pK9/3qIZ3WuAR1pIK/jS8er4g1+U6+pap
	rT5jEupSjTOwufoygYV5J1CaNlvNH+PnHGat9qS5SQpB4JkFds+cplYgOevFTPCrx28JlOxhQCl
	9aIV6Z2d8Bhcnn47R+xISjkcUVbRMZXpJ05EAVDTbQBHx7zi5ZYv2m5rRJv36I9kJ2pabqodrcs
	O6ZN5E8c2j78Mv6SgDveGEx3DDkrohUkt3w==
X-Google-Smtp-Source: AGHT+IG6vGm0nQ0pWX1WGE2bVfEU38Z2PAhb4AU96/aUvxjfe+q2Od5M4pBgLs+kqh5sp2Cz3h3gxQ==
X-Received: by 2002:a05:622a:288:b0:4ab:77c2:af0a with SMTP id d75a77b69052e-4aba3c48622mr344344701cf.3.1753184225705;
        Tue, 22 Jul 2025 04:37:05 -0700 (PDT)
Received: from Gentoo.localdomain ([191.96.227.162])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b25a18sm52457651cf.59.2025.07.22.04.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 04:37:05 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: rdunlap@infradead.org,
	linux-kernel@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH 05/11] There was a space between bang and shell path,fixed
Date: Tue, 22 Jul 2025 16:47:01 +0530
Message-ID: <8fae2492505518cb304ebfbfa61470ea7a87bad8.1753182971.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1753182971.git.unixbhaskar@gmail.com>
References: <cover.1753182971.git.unixbhaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added the shebang line at the top of file.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/admin-guide/aoe/status.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/aoe/status.sh b/Documentation/admin-guide/aoe/status.sh
index eeec7baae57a..83bb8eb229e7 100644
--- a/Documentation/admin-guide/aoe/status.sh
+++ b/Documentation/admin-guide/aoe/status.sh
@@ -1,4 +1,4 @@
-#! /bin/sh
+#!/bin/sh
 # collate and present sysfs information about AoE storage
 #
 # A more complete version of this script is aoe-stat, in the
--
2.49.1


