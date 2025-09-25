Return-Path: <linux-kernel+bounces-831596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EB7B9D173
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811A04236BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386822E0921;
	Thu, 25 Sep 2025 02:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7Sbh+js"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321A0DF49
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758765989; cv=none; b=T7HHBD+GXvdwbsTlbORc81qH+JhHYdtAMJKbJ4AVplGu4NsWcxxzXoTmU+Zxw9AKch1qlGe+OLirj95qO/KXl2I4SFUy4Bho3k6i7ghcJ3BYaOO/GkdqJXSnK16LFq+uqYGkeToyM4oGePXs0hWn2drZz3Q1ftHR7UpVtioqF68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758765989; c=relaxed/simple;
	bh=emM7Hbp4+t3hKY7RQRIqu3zLRsfIXIe2RIjkPWAHEoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C+DFIL7liwh3qbx3ch9e7bdwvSVtHiVlEwIg4OJU4WbOpqcYuRM76Apf0y76/d40qMZGwPJIIQKTQwTg8O0F7y62ADTlHFDrN5qtjPCBhs+v4BR/DHYsQj8YNf17hunZfhYgX8YN9uzlWRbsBS+xz0d/o297B8A/yd+Oww00zFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7Sbh+js; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77f3405c38aso552396b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758765987; x=1759370787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tU/TSL5LhuP/twx2wBHqp/4wp73W2M92Uj8iJaHRWWk=;
        b=R7Sbh+js3985Cv86XKX7c+hizRoRaZAEzHy6GBICDRCNZv4uMUNHxuBUWHzoGifbh5
         xi4QrAkQbXF/V534XDLVEnxZC/bg861LJkqaXEiaGkYa1NGUGXC0XBmqvajI7ne7nfV5
         eUeBYTektSS8tj1OQ/3HVJFERuurHDrXiwhW4ojsWCyya4y1k/lerQ2Yj+/W3DWxHTN3
         kvP0fbGrHUKEGDsDkdeuGDcpzYoKhSRAy/NFc5CpeTrRTN95YDgJ+h4S0hIaerdOCZEb
         EHaRbEu2evJmI5gWLODiE+g9jkX9n6k3mEAHz+R3mG3ziB32BWZFLIvRpwMEPoIwc8QQ
         gO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758765987; x=1759370787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tU/TSL5LhuP/twx2wBHqp/4wp73W2M92Uj8iJaHRWWk=;
        b=R3TOI7jra4D7n1ZlotB4l2PwuHDzaQJVBwKfZrGo776E+Bd2XLQMEez3kHdNkDYOF+
         d0uCoOrNSXd4AyTtc/1s1yygqd7l0WPsr7gt0MVQrFlQAfJdKUE9x9xsUHBgy3zuuIrO
         ek9lVG++Ddi6Q5yYpy99oQRNH/Ab5ez8AxMWSKoQQDgTh73fOheWOgDO5yaGG64ByC7v
         E1Lu24SPB+3CXRLUqhpjcTWA4C5QRO3WaV6J6TF/JLtTr3JzAfof/yi/VSasGCULuubt
         b0cb9zQV4qCOAsPb3HauXlZDFf3GNGdqGAfua1ZOlFL1nVkKLR/Rp8rDqTHpFl+hiPmX
         rxTw==
X-Forwarded-Encrypted: i=1; AJvYcCV0nEUAZVJX+ve0fNeG0xNda6cYWn95geASN4iW2gXfedw48kPuyu62EgUZEKWMnYBF/sMfPbVDuvcI0o4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcZvhhwaCcIv0y+WqUYAzW9Q1QKq0GDWYMT/CB2FKMjwxtsjb/
	k6J/3aD5gVJepWjqVAN+DSsYxfK25cvY/5l92KJWOWQ6ZPDjqhiCGs1S
X-Gm-Gg: ASbGncu9O91OKTEroNWK40cEe3OT7Za5ODXFAUb0DMfmHSaYjTyFds9oOJ/K87+bSTV
	hag4zKkjGuA8yXiqEW7FVhrzs4LlrcUMVuMCqFarqSG9B+8ABWEZeHVEG2DmPY6G9zAyBc1/r3N
	c+PdtNa8CI5vBmCnq/1FwYWgYwpYH0eaUAt7At75lVgImxftKDkAsqK6UJH2cKDKyfKHC85bZGR
	t5wrEDf5FQZ0iTPiL1bZHR1qQ6lHoOu2kiZMpzC4bK1jVTSWFd6bXOrUTLKioADumS/kSeiRewy
	e1aZVGRgW4/IUnqGd7iY9BpJllodoQWlv4hzrWxm4DaTAHMmfyxALsFHV59zxtj0IQaBbNz3YLD
	w++SClMhacOn9TYOTnL+MIKQi0Ttaki4kDoS9zOA3l8PDwL1iNF8kbA6WeFwjpgY8j+nsmyirhL
	BT/Y4=
X-Google-Smtp-Source: AGHT+IEGkxaZs777ffJyo9MgmjDEDAVLnqbymp9F87MoJbNqiIXjx0kxb58hxWECgzHw3b5fO4opNw==
X-Received: by 2002:a05:6a00:4654:b0:770:54e6:6c36 with SMTP id d2e1a72fcca58-780fcdc9112mr1994132b3a.7.1758765987402;
        Wed, 24 Sep 2025 19:06:27 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:87f5:62dc:5f13:5ae3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c27733sm394133b3a.95.2025.09.24.19.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:06:26 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: adilger.kernel@dilger.ca,
	tytso@mit.edu
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix allocation failure in ext4_mb_load_buddy_gfp
Date: Thu, 25 Sep 2025 07:36:21 +0530
Message-ID: <20250925020621.1268714-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hi Andreas,

Thank you for pointing out the fundamental issue with my approach. You're right that removing __GFP_NOFAIL creates a worse problem by potentially triggering filesystem errors.

I understand your suggestion about allowing the function to return errors so the caller can retry, but I need more specific guidance on the implementation approach.

Questions:

1. **Function signature change**: Should ext4_discard_preallocations() be changed from void to int to return error codes? This would require updating all 13+ callers I found.

2. **Caller modifications**: How should the various callers (ext4_truncate, ext4_clear_inode, ext4_release_file, etc.) handle allocation failures during memory pressure? Should they:
   - Retry the operation later?
   - Skip preallocation cleanup temporarily?
   - Handle it differently based on the calling context?

3. **Memory pressure detection**: Is checking (current->flags & PF_MEMALLOC) the right approach to detect when we're in memory reclaim context?

4. **Scope of changes**: Would you prefer:
   - A minimal fix that just handles the allocation failure gracefully?
   - A more comprehensive rework of the error handling throughout the preallocation discard path?

I want to make sure I understand the preferred approach before submitting v2, especially since this affects multiple call sites throughout the ext4 codebase.

Best regards,
Deepanshu

