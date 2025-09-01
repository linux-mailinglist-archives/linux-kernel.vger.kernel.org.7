Return-Path: <linux-kernel+bounces-793654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ED5B3D676
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D92189844F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 02:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C89231827;
	Mon,  1 Sep 2025 02:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuMZeGxP"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D3B22157E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 02:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756692044; cv=none; b=snw0Hl7Uv8VKzWcS36VcWBUrQIiKVh9KhYhsldAf87gnIdfH/LqPaBnlsPHUSZPPxhv0t7GT9rPgLi96ZeIW/sO2jr+FrX75daU9zxnx/sgII07VojLFxpdZ+dBCe4+ahhLWrr3Y9zZnvXcD95vlVI5t2cMHDuuKzr62tXfsejg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756692044; c=relaxed/simple;
	bh=VjSEQuTk8Aic2ULjMShGdIHNMpD4YMEhT97QSvsWINM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WAXu853WN7BmScIZ5wsukoKOqUPzL8wWRcmqTbNlx0r2DAWe9QDR/OT6P48POD4ZYiMXeiayIkgzw4lPiduQo7IqCzbp7lqOpROLdu+y0pmkPnexmMSQOcDcUVh8vJbMq5eHVwo0Zi1AJUwCHw01qWA6QoizM/PSTcJEw8RZvBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuMZeGxP; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70de9ffcfffso37798436d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 19:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756692041; x=1757296841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n71lxSZhtaKmDioqwBpuFWbtYkrE4A8cOtuolZZ4xFs=;
        b=MuMZeGxPjobAqstBIsavnDZ3cXis40ihN86kNASMweGoywuMnXw1GS35UC2EcFD7qO
         /ApEw92uXKd8FdAvpCOTEyLMe5PFAzkDj0J3OwHSTF2UbDh8X/Pq8JCbb1WLxNfwvSl+
         cp1yLR82sfsHS59Ad7sOxBK7Gb8mfFAhxca3RyXE1dlU5Mn7V90+q7gybIkVHSJWoxiL
         mqAA2L3RhZbqmJh1Z+xUt5/0IdKJOTX7KF7ylLUOtdQORIMbYuNcFHt4z+D8nSCA6dVv
         GN3Q4I7d+rMNAaBxYM4DoOKGjDDvijEPCC/wcRbFauCivGluFfepkiOQQIkT4lXJ3MoR
         bfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756692041; x=1757296841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n71lxSZhtaKmDioqwBpuFWbtYkrE4A8cOtuolZZ4xFs=;
        b=AbhNQrLQWjOy5dY0CvW0eYKpRoJggSZtZvnFcfEZK9INkIjWQFRlE731Qkim4Y6Vtm
         1AusW9q0LklDKBFyTRogFTqDHNOxUtEedsIH+fLbnWBAX04XekzRlELyeNjjOZvCNNde
         +w01EAcifG2YthDBSJHwfMG5xPLT7YsA9fDmfsVeJKFVs8dS6DUnl4n4qYuXjbILBYX7
         69dSLgd1kLSgTb2DH0kz7IXd1NwvUcxq7sr5zCpp311sgJvo1Vy17HWaZyI3fAFzfd07
         lYlnWPyq84NO8TIx36nwafcjCKLUBbvwx7LSJ76h0oHHoYqdk/oqjgYeqduypB6XoYBb
         xLIg==
X-Gm-Message-State: AOJu0YxgFu7aK2vyRQyiuOzFJw1wk8Z6Zy0AZLMD4o4RHNSD+aqh5e/3
	oEtIeXPj6Lnbip3eLtecxVjlWGwR2PWKT/THyHFWiKwJ7l7C3e0rjPTqoTk/Jw==
X-Gm-Gg: ASbGncvFesQ9sU3WHroNldwyGanoO5jEOh/EJuzFCD2hD2hga+y425XDWgqutyK05Ex
	LK4FhUnuCuWYWPj4A1/3OYqSiBoj2oUZaxvoeq2/nVHiKJnyPu/voVXYtsF3i7TgDAIkffoR5gw
	UVe1G9sFU6/+MAVIBVQo2S+NOuMWPvvnK5AL6H6R0afsnKg4cvGzOHyuH22Q3tCvQy+jbaeRceJ
	LPAlFmXLhSypUIYnpaUnl/YBynlQucX+6ytjTsXiQwcPjnCfFA08e6uLUyKihtDtxEXS6esmLVs
	u6J1i3BZXtQRd8xarwY6QYBZUzjSz08IUhd5a/2YZJsTSN1G5U27SFyuN7q4Tz4f6RKLFfIRsf8
	5ix00S4nveABS61H0d4SjZUknzdnElDs9q+47JfsB31me30c8R1mRtiyIeZQTKQaDavaL
X-Google-Smtp-Source: AGHT+IEaGu+VYdICMtJaTj4cIkBGcsfziLHVIU6jPygVTgEEWqJYHyBwxY2MAfxI6b1oIhohl443gg==
X-Received: by 2002:a05:6214:2529:b0:70d:ce68:e019 with SMTP id 6a1803df08f44-70fac6f9d75mr58888606d6.8.1756692041077;
        Sun, 31 Aug 2025 19:00:41 -0700 (PDT)
Received: from localhost (modemcable197.17-162-184.mc.videotron.ca. [184.162.17.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70fb25c6f49sm32124496d6.15.2025.08.31.19.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 19:00:40 -0700 (PDT)
From: =?UTF-8?q?Jean-Fran=C3=A7ois=20Lessard?= <jefflessard3@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] docs: ABI: auxdisplay: document linedisp library sysfs attributes
Date: Sun, 31 Aug 2025 22:00:29 -0400
Message-ID: <20250901020033.60196-6-jefflessard3@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250901020033.60196-1-jefflessard3@gmail.com>
References: <20250901020033.60196-1-jefflessard3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add ABI documentation for sysfs attributes provided by the line-display
auxdisplay library module. These attributes enable text message display and
configuration on character-based auxdisplay devices.

Documents previously undocumented attributes:
- message, scroll_step_ms (introduced in v5.16)
- map_seg7, map_seg14 (introduced in v6.9)

Documents newly added attribute:
- num_chars (targeted for v6.18)

The line-display library is used by multiple auxdisplay drivers and
can expose these attributes either on linedisp.N child devices or
directly on parent auxdisplay devices.

Signed-off-by: Jean-François Lessard <jefflessard3@gmail.com>
---
 .../ABI/testing/sysfs-auxdisplay-linedisp     | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-auxdisplay-linedisp

diff --git a/Documentation/ABI/testing/sysfs-auxdisplay-linedisp b/Documentation/ABI/testing/sysfs-auxdisplay-linedisp
new file mode 100644
index 000000000..63c47f192
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-auxdisplay-linedisp
@@ -0,0 +1,90 @@
+What:		/sys/.../message
+Date:		October 2021
+KernelVersion:	5.16
+Description:
+		Controls the text message displayed on character line displays.
+
+		Reading returns the current message with a trailing newline.
+		Writing updates the displayed message. Messages longer than the
+		display width will automatically scroll. Trailing newlines in
+		input are automatically trimmed.
+
+		Writing an empty string clears the display.
+
+		Example:
+		  echo "Hello World" > message
+		  cat message			# Returns "Hello World\n"
+
+What:		/sys/.../scroll_step_ms
+Date:		October 2021
+KernelVersion:	5.16
+Description:
+		Controls the scrolling speed for messages longer than the display
+		width, specified in milliseconds per scroll step.
+
+		Setting to 0 disables scrolling. Default is 500ms.
+
+		Example:
+		  echo "250" > scroll_step_ms	# 4Hz scrolling
+		  cat scroll_step_ms		# Returns "250\n"
+
+What:		/sys/.../num_chars
+Date:		November 2025
+KernelVersion:	6.18
+Contact:	Jean-François Lessard <jefflessard3@gmail.com>
+Description:
+		Read-only attribute showing the character width capacity of
+		the line display device. Messages longer than this will scroll.
+
+		Example:
+		  cat num_chars		# Returns "16\n" for 16-char display
+
+What:		/sys/.../map_seg7
+Date:		January 2024
+KernelVersion:	6.9
+Description:
+		Read/write binary blob representing the ASCII-to-7-segment
+		display conversion table used by the linedisp driver, as defined
+		by struct seg7_conversion_map in <linux/map_to_7segment.h>.
+
+		Only visible on displays with 7-segment capability.
+
+		This attribute is not human-readable. Writes must match the
+		struct size exactly, else -EINVAL is returned; reads return the
+		entire mapping as a binary blob.
+
+		This interface and its implementation match existing conventions
+		used in segment-mapped display drivers since 2005.
+
+		ABI note: This style of binary sysfs attribute *is an exception*
+		to current "one value per file, text only" sysfs rules, for
+		historical compatibility and driver uniformity. New drivers are
+		discouraged from introducing additional binary sysfs ABIs.
+
+		Reference interface guidance:
+		- include/uapi/linux/map_to_7segment.h
+
+What:		/sys/.../map_seg14
+Date:		January 2024
+KernelVersion:	6.9
+Description:
+		Read/write binary blob representing the ASCII-to-14-segment
+		display conversion table used by the linedisp driver, as defined
+		by struct seg14_conversion_map in <linux/map_to_14segment.h>.
+
+		Only visible on displays with 14-segment capability.
+
+		This attribute is not human-readable. Writes must match the
+		struct size exactly, else -EINVAL is returned; reads return the
+		entire mapping as a binary blob.
+
+		This interface and its implementation match existing conventions
+		used by segment-mapped display drivers since 2005.
+
+		ABI note: This style of binary sysfs attribute *is an exception*
+		to current "one value per file, text only" sysfs rules, for
+		historical compatibility and driver uniformity. New drivers are
+		discouraged from introducing additional binary sysfs ABIs.
+
+		Reference interface guidance:
+		- include/uapi/linux/map_to_14segment.h
-- 
2.43.0


