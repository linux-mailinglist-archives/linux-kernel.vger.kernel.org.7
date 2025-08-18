Return-Path: <linux-kernel+bounces-774575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD44B2B467
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB1F2A1B57
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 23:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E2827F19B;
	Mon, 18 Aug 2025 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MQ9eTwgf"
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151CC27D77D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 23:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755558643; cv=none; b=CIarRYegfKKMbRHkwaAGUhZj2Sy7Qm87c9kswQhEmUPJKdt65Gd8lL/K7LUJq+BrjUANVZH21lqilTTYsMsl25O38yESib0aL7iYhpan5dt/lbFTAOBYRLMjilgcAr9ucwcVbXIRtOtC1dusfuB13aM2AmcWSNTc3l2voRWCpKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755558643; c=relaxed/simple;
	bh=0zxJTqS++QzeTMN7ELVT/4x9pOXf62yqfBvIp9OiakU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s5bcigIYlJY7MnvZGFlLxrgHHpO83K3WzcMoxZhVlB/GfmJsm6C08V73pFmzMGR8GJpbNwkpVuACIqPB+g53/1LN2j8O1YOyNCBAQ3mqvDIbxT6VsY5t/lB0Ee8LSw8uP1F1mbRi7ARl/FbOf7GPQRxSSbVLzdKp2W3w0lEz6hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MQ9eTwgf; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-88432e62d01so633431039f.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 16:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755558641; x=1756163441; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bjzFjLZ/9nuKad8tzU4AwxzdMRz4hEl/2ABsOkFafDU=;
        b=MQ9eTwgfhKPWap+CTiMuwuual5qQnFFkODg5wGKKvtAKNcUMsitkeS3Qe4Vf4x2pPa
         GJ6SW8HnX/v8s76W5xG9FXUUxEsv/2z1jUm6Zyc5q0OPsIOjMshKMVhECJMDvwwpPEFk
         3AZrDvEhS+TWSXqBqP7R5EQLZH0oBkwyy33VDBTpeUu2MfUai4CX/H7NhOYugeNIY8yz
         2BvwLb3YqKKqrbCZnPKQ6S/a6W5TFHTVRUC764ZqWxTbPa8JiGNYTz8qQb4ydwVuYG0D
         zad28eZJk5cWEgZEUihL1NM/QllI7Tiz3W9iky+DFm+v9eaM7cLMYfGbtbCizAvTl8Ih
         XcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755558641; x=1756163441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bjzFjLZ/9nuKad8tzU4AwxzdMRz4hEl/2ABsOkFafDU=;
        b=VC9fUHSitPZuTfBxXdPvoVq3KVhKSvI3OLRu0wGyOhzsuRlqDpo6CbIoEQp8H7c9fb
         73FNQMecI5q7c4/RElapT1MPNyTcWpbpqdTiaZXkrIP4BWzMyyfbgRDfVqsMKQcxhQOL
         AMr30uUJ3XshDaaGSFAXoRtDLAzWS3fMAnP7sUSYXHxPTR2qLsg13SHxM37mrT8j4BWd
         8wx0qBTJYxiPTbawCUFfGLvxlyB8sihveW5CaaDjNd9d7wggrfzVcx6wGOFlu+xgAwOn
         SrPfph5+2v+zs7KBbX7Hrbptno45l1obqVocK+TEvCL/tdri3zYMQ5fX+XqDl3uaJKa7
         U57g==
X-Forwarded-Encrypted: i=1; AJvYcCUwJ87djIY2DzrvlyD1jq9xRsLF+pVYjNg+dPNrQxk9ZNyrA+HpKY304t/nkp9SuQPaTbj1iX3QdFYb4sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHv0F3qekv8t0zF2VQlrLr/BvjGXdYQ08/xIPD2ASzw/VXTmAQ
	U1KyFonDf+pxNP9WTeQDLiHdw9dkMbcYglj8PALNBqnVoZJywn2JUEBfMosv2gk0do+f7HFpRHD
	Qa47dSdKiKA==
X-Google-Smtp-Source: AGHT+IGZLTz+lqQtSWbfLXXAEC8acdwTT51EP9+iU8mLrGDi0z1WLLK3wDQzAomLi0As6Qv94y0KEgUeoz/L
X-Received: from iojp6.prod.google.com ([2002:a5d:8d06:0:b0:881:77ef:6edb])
 (user=jdenose job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:3fc3:b0:875:d675:55f2
 with SMTP id ca18e2360f4ac-88467ede8f2mr79072139f.7.1755558641274; Mon, 18
 Aug 2025 16:10:41 -0700 (PDT)
Date: Mon, 18 Aug 2025 23:08:48 +0000
In-Reply-To: <20250818-support-forcepads-v3-0-e4f9ab0add84@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250818-support-forcepads-v3-0-e4f9ab0add84@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250818-support-forcepads-v3-7-e4f9ab0add84@google.com>
Subject: [PATCH v3 07/11] HID: input: calculate resolution for pressure
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
2.51.0.rc1.193.gad69d77794-goog


