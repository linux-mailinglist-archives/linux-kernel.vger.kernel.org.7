Return-Path: <linux-kernel+bounces-769479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63639B26F33
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0F35E419B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D69C29D27E;
	Thu, 14 Aug 2025 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h6aaJ7XJ"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAAA23E32E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755197107; cv=none; b=TGMUyl9iD44iS7EzRP3ns9yz/DggezxVo9GrurF9BXvJGrrl5AiesivijXgIyQTEEHbonvBI5GWBlgMqD1dSsFFfYEn1NIDdH1fmzA0XEAsMoli8c8c9Eh7I9dGkjSZPMpxkUs4gwWZJnEllPZkctqy/unfMG273Z8xSbBAfIz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755197107; c=relaxed/simple;
	bh=IIWLTCm4iM4o2ycYzWp3RSfJLjwCX7bGklc9T/Y3Grk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfPQmKv+G2ITg5n4Q28ANLPvs6mM1ncuatT/iFDC1UFIYbZxvc9mIh+IXHYsWeOZF22BN/drtseTM/ATAQhY80kuXHue/0EFaA/W0+s77zVltYVIPFfj2Ysz2Kz1CFX4T/UdwAHm3gf9LmANgQM+JTICTuQj+gOMM7QT05ZboEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h6aaJ7XJ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb78fb04cso209138866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755197104; x=1755801904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgWNu/lsijOtg6th5ui9qnvyOY7w+iUxq5UAg/411GA=;
        b=h6aaJ7XJ7TrWfcHWSnnAY5AATbQNWFemFGrQtm0S2+mP7jwJ5bJS+TMCaptdh1n2F4
         D95jO+uhwHsUoQheh7FYKnDEVNBWnmTL895CXDIgeo+fMoPk0ECJISXOqZpF8uilWrdD
         U9/P0LmHxAit1cqb59q6Ow1KP1jMt6v8dvOLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755197104; x=1755801904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgWNu/lsijOtg6th5ui9qnvyOY7w+iUxq5UAg/411GA=;
        b=O8hO3rccwqrAYaPZzIeSwxVZX3/INxT0qXaE5lBanq+ygCcTzLNdr6/tJeNXfjd50l
         bhSqWvMUbT1taq/AzH79syx4QkMIAqbCNvub5eCoND6rQL5L3tLWWeIvF/NBE9NPUNly
         VvzoQhUNRPg98QpJQm77Nr+aIiF07Ej2BN7FvuN5FzvCywT9vzKD1sCt8IHTGzzX1TJC
         8SwimFw3q+FXFKU7p5p+FUvrLrrKW402d9yMHASyYxfsWWh3PMtkRpWc9xYceMIcAKXy
         oIBoCqeoIWNdzxHxTpGXESGCzmSp5gIuDZ3yicdiXGXVyMREsZEy92qH/HYDheXvT/Lw
         LC8g==
X-Forwarded-Encrypted: i=1; AJvYcCXXJ6U+mO2g9KO/G8yYabtEZGm0IZeBIWmvHYU084CSblHz8q41kXO79lC+2S/tTI702BIYiqdj1+iJCtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMN/LKj1C8q71jXyhhwIpK9SC+1rTGOfhXj2jH5UZmSDU7LPnq
	bQ6/IobpMhtxYZokKTasLV0Kn3aZ8eroclRt4B06+VJm2nDfvBDtXuUCND/ey9erWQ==
X-Gm-Gg: ASbGncttDV7y4Uck2dDu5+cTJbtNUf9sTgCwDahRXbfyq9xCWGU/aCOK6YD4gF29yku
	9H0bYvYV3+cNOLvColn1YhuShmYzlRMAqQzWuLnKhX+itiP9M4B5xi9Ml4Ri+P3s2zpSqinOnNE
	ou0hxcRwNaVoJFleHQF+ovcxmPwyqQu/LRpQ9EP4DISE9jkLtd/bwfzlrdl+uE6LSDpTPuyBagy
	3M+qNEuNIZ7ga8Oi0qYSnkW1qjLH0Zy3LWI0CJ40PBM1mzM6vAp2QmHKtgosS2lvrJR+k9eoTS6
	NYl9UCeV7Ia8bo+KFbr+MVi86pjdQr+w6xdJBTNt+X7YvnMDNhJFzQL8jUdWI9qJj217kcJBwSE
	vEbZtTZWlpwemXm7mlp3F1suhNd7/D5O3DC27wLMC+vTkxPBXs/qgcSO0k1TWUpS0B/akMzAaTf
	hQCbJu0ukZs2bd
X-Google-Smtp-Source: AGHT+IG7W1HQOHW0+HQd1j2RDcUydykQcA+021giU1BAHPPN8iXToIIj0I2at9PJj19MrWet4LHEkA==
X-Received: by 2002:a17:906:7308:b0:ad8:a935:b908 with SMTP id a640c23a62f3a-afcb996e8d9mr387128866b.30.1755197104266;
        Thu, 14 Aug 2025 11:45:04 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (37.247.91.34.bc.googleusercontent.com. [34.91.247.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c0f4sm2614772466b.106.2025.08.14.11.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 11:45:03 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: Guenter Roeck <groeck@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Venkat Jayaraman <venkat.jayaraman@intel.com>,
	linux-kernel@vger.kernel.org,
	Andrei Kuchynski <akuchynski@chromium.org>
Subject: [PATCH v1 3/5] usb: typec: ucsi: Set alt_mode_override flag
Date: Thu, 14 Aug 2025 18:44:53 +0000
Message-ID: <20250814184455.723170-4-akuchynski@chromium.org>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
In-Reply-To: <20250814184455.723170-1-akuchynski@chromium.org>
References: <20250814184455.723170-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This flag indicates that the PPM allows the OPM to change the currently
negotiated alternate mode using the SET_NEW_CAM command.

Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 5739ea2abdd1..5ba8b1bc874b 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1616,6 +1616,8 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
 
 	cap->driver_data = con;
 	cap->ops = &ucsi_ops;
+	cap->alt_mode_override =
+		!!(con->ucsi->cap.features & UCSI_CAP_ALT_MODE_OVERRIDE);
 
 	if (ucsi->ops->update_connector)
 		ucsi->ops->update_connector(con);
-- 
2.51.0.rc0.215.g125493bb4a-goog


