Return-Path: <linux-kernel+bounces-755294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5535B1A438
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B96DB4E1893
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411C52749CA;
	Mon,  4 Aug 2025 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LTZwAZ6Q"
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A57826FA6F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754316689; cv=none; b=F9AicGOrsVJFEIicjglAbpt1mz8EFjlZvoIP4lA/IX3fpI1yhesTaWsKvJwEa97ENe4/MmaeJ8pc9OhTbc95LUWn1MuUHNOZCFxRtYOo8I2RYDu09LmNiYrgETMBYu5LmdlE7P2MN3uXDs/QR0mwtqvN2fiQ+Pyti3e/yEUHRjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754316689; c=relaxed/simple;
	bh=LcDf0eRQa6CauF9x+0Xls3nBIKLOdfur99AWgEtgPGc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KfChRyJ/QP0m+7JiUvIc3TK/HNAZryPh0C5/F0zfDiZHIhBp2Ht7nq9mUfoCVIeFETc0TUbJiNfSe/rP5B2TylHhbO7sWcmp3LS8fwMaH7Wn6Yo1GBUXPr71LCqEDrj0XdyIlgajb/9kWZzGZwKygM8jTMBAqMu4r/9kJ8oRkUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LTZwAZ6Q; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3e3fa175c41so39290735ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 07:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754316686; x=1754921486; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s5ue1ow6B+qjHFJbRE57LcW6Xcqfgr6lS2a71BgvhiA=;
        b=LTZwAZ6QzE/FBZEzcr6e2oYqNdc/y1wLFNfCqarlQCaj3vzyKuIMx8YAeKpODY4qkj
         3X8WydY5yi+6HDjKbyqsHuDfwXLEXLjHRaHS1C9DZVQcVlBrivUHSZtj4EEoLUj1YXIz
         LPgirpiDjRQylO0TAeHabk6zYhFF/WpPZgvV/sNx2vDlunIGBy52ER/hk/qFQGjAfnMC
         Krxsb68qVBSB/RElLYhOf0tmeWBk6J8NK6YMkqFwIpAWxe6UhCk+g4Yob3drDn3mcfBa
         gNcqNrERixAnBXPrUpRyw3tN6SVupAoNk2kDzYLNHb1kpy6MFWNeL+93gAkfXZ0bDioo
         uZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754316686; x=1754921486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5ue1ow6B+qjHFJbRE57LcW6Xcqfgr6lS2a71BgvhiA=;
        b=BOkjnwbMDQC1SxbSQ4dz1vd1662otubeg1gOC7eKYIO8WFtkV+z0hJxWANK8tOOqaG
         MPVAuzsxC0Jv6tLDjfrspPBOLLjVE12wz+fc9k1NJV+ianMKCWtoepPfFELB+grJiwFV
         GsvIuWfqlzxDOB6SgFl9xnd8FVI2QBzvw7/ynYqqnD0FGXjzw1xqOuqgZ22LAs14EXS6
         C4i0eOfadpQxQ3AHxHfwtlibRN7so0Uf66z1Yon0uHJHGObhuCzYwGA5LF6EESfhAKoH
         IeqjzsP0JnVfEC2LKEr94Afc0MSaser41uWPKPf7nazkeLLFBEmKIVoCYIwBuTkGAe6X
         0BcA==
X-Forwarded-Encrypted: i=1; AJvYcCUbFEUg4bRY7QysKPxNM4xksmiOYOHWURSiXM7TK1f3JHgmIS3hgbFGdx9kI2FnmA6mj7Z9edEAp4HlIOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1BFLMq5G9nBgahose1S58SQA0NB+POqYI8n/G4A7ZlcVulty7
	oobDcBqv9jGGUu79BBwGDz+vfCitrvhPlFd5vWaJpVCFFo7o3xo4NR0Qe9ou4zCRi8l4Nz2W0ZN
	cD8+APvgFvg==
X-Google-Smtp-Source: AGHT+IEvuLZqvj7ju8vg5N1aQ1C6x+fs98fRd9oWA6NKgtlabYP/rk9fvPfLoXJvjw/4lU+T796rg6z5WX0F
X-Received: from ilbbn7.prod.google.com ([2002:a05:6e02:3387:b0:3e3:eae4:c433])
 (user=jdenose job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6e02:398e:b0:3e3:d499:73f
 with SMTP id e9e14a558f8ab-3e4161b735cmr210331175ab.18.1754316686600; Mon, 04
 Aug 2025 07:11:26 -0700 (PDT)
Date: Mon, 04 Aug 2025 14:11:22 +0000
In-Reply-To: <20250804-support-forcepads-v2-0-138ca980261d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250804-support-forcepads-v2-0-138ca980261d@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250804-support-forcepads-v2-7-138ca980261d@google.com>
Subject: [PATCH v2 07/11] HID: input: calculate resolution for pressure
From: Jonathan Denose <jdenose@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Angela Czubak <aczubak@google.com>, 
	"Sean O'Brien" <seobrien@google.com>, Jonathan Denose <jdenose@google.com>
Content-Type: text/plain; charset="utf-8"

From: Angela Czubak <aczubak@google.com>

Assume that if the pressure is given in newtons it should be normalized
to grams. If the pressure has no unit do not calculate resolution.

Signed-off-by: Angela Czubak <aczubak@google.com>
Co-developed-by: Jonathan Denose <jdenose@google.com>
Signed-off-by: Jonathan Denose <jdenose@google.com>
---
 drivers/hid/hid-input.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index d42c1fbd20a1cc01c04f93cf10f1d1c18043929c..1d59787bd0c0e251698e2a2944dae1c4a96adefe 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -303,6 +303,19 @@ __s32 hidinput_calc_abs_res(const struct hid_field *field, __u16 code)
 		}
 		break;
 
+	case ABS_PRESSURE:
+	case ABS_MT_PRESSURE:
+		if (field->unit == HID_UNIT_NEWTON) {
+			/* Convert to grams, 1 newton is 101.97 grams */
+			prev = physical_extents;
+			physical_extents *= 10197;
+			if (physical_extents < prev)
+				return 0;
+			unit_exponent -= 2;
+		} else if (field->unit != HID_UNIT_GRAM) {
+			return 0;
+		}
+		break;
 	default:
 		return 0;
 	}

-- 
2.50.1.565.gc32cd1483b-goog


