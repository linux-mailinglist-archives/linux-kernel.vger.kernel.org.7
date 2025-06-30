Return-Path: <linux-kernel+bounces-709895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4922CAEE445
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 18:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87382164BB3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 16:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CC2298CA4;
	Mon, 30 Jun 2025 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YHNEn+uX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D248C293443
	for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300443; cv=none; b=fFVR6Ma4Eu3DVHHUgpJodfYyYaPoE8hsvAFV3hoYQoeFTdfkHFFCdlwgng5npgPPz7Vbql9MlJVeYKLW+D8tf+5WzgrgySw3mQ/lYrkNlufLPUmWP5CFoh17KKPugB4gn5aaRCb1+Cj4leuWMc1j/WjlA1+EU0C/jmRvAVbjj58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300443; c=relaxed/simple;
	bh=foooJvFPpaD5U1NIc0z1whyvvGUcJuzLkZ/bh7+WhsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WStHmUJjsKNXVpnwdHLKzOAsDYVLrtuRa2LAjqRZEGa1u8zFkcg1fncL3t+Lrrqec2uLfPSN0JnLQB3XVXILyqukhtWulBqE776yvQA5wp0Am3oK94Ei7n3pmhCBUb4Ys6VaNziA6IsjhD++nHch7pLl/cHdnd1vP7fg8Pkth3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YHNEn+uX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751300439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DdCDc+5wwhrTWZmiggiHt07OVS9wseyBUBrB0c0lZSY=;
	b=YHNEn+uXzVBzU/XwxZMw0/d3gYAWzStdYNp7808Xf182VgyNHjsLFfd0rfJZP9kymnNeZx
	v3VjZ/Sd8k4prAq5sRilREDE9fb5j1kUNP2UL6CJBXV56Urf6brBzk0Zwz9RHYRwGE+50q
	ylcqF6xEfztZE7DpDX7etb+b1wPWsHs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-6wIahQsgNS2UUiOhHUsPLg-1; Mon, 30 Jun 2025 12:20:37 -0400
X-MC-Unique: 6wIahQsgNS2UUiOhHUsPLg-1
X-Mimecast-MFC-AGG-ID: 6wIahQsgNS2UUiOhHUsPLg_1751300437
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4530ec2c87cso15206055e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 09:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751300437; x=1751905237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdCDc+5wwhrTWZmiggiHt07OVS9wseyBUBrB0c0lZSY=;
        b=RLY56dOPTaKEoSt1qw7gOE4Aortpv7Bp9Z8hsV2xwNJ1hqzIX4Pz6827/AWpce5gZr
         bGYRXghDlmnh0OqRlCb3LVhL7jIMVYh/m92IFVE5TdaLNl5jFKyaVWGxHFl9FBzeLqsc
         9dQnKnDw68djI4pdPOjOo1YLdskuhPZtANwCLh8BQEAm/OCl4Dh9rdr+ePlheLehm3+T
         DbI4Jtj5YF2ROsWHjbAFydTrZ8AAzbvP4C3z/YlZHMc8QUOazYdxDwh6u87jZ9n1lht9
         qcbbxmSJ9JwPKoCTTUssdk9QDWr0fcGkOeGuqUfOuMkMYlkoxUEpjAJwv/cO0cwfHO16
         U+lw==
X-Forwarded-Encrypted: i=1; AJvYcCW1cNo4/9YUxL/FXJIdsjNEfkFmU+puBTM1JFJmmkiTSLzerjj283aKXkl9wjzWvIgtTY3kfIWXu3+EXTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9abFpVrD6KiXoGRo9c4g8AGvBWNy9Q1mdapF4H0kxPtvK5dqf
	qDAotDl7DOTpFIcUfDv4DYyoCBUEg+DYvOQMV7q2GtDkgtOTHpNj3xJzhZSctahLJUodtPgWEsl
	hjOp8J81YVJrkOdonLyaKUW55VEe9EfjBhT9EjlJ/Yd+nseNBMhAr1DZaO+oF0ER5
X-Gm-Gg: ASbGncumVdRtLIKOKqLWq6Lm3v9dO0+E8DINeADNeO5klrL9kgEYV6Ub9UdsNDHlXfj
	hw0hqlqrqiw43Hib8Y+svuQkK/uxzCTDGDGY0umRyqGLj379Gy7Qk6NQa5adeM5gS/taIwGjfkt
	awZS0/QKC8tx2oxycXh2KOPTIol0iYxXDytUIN5xuz1qqobIQ3WZ53c5eV/9eDobxR2mMJw7aOb
	E3LEVtmoFXGDZjmblh9WNxaGOJhg/hgvLbDLvUym/YyAmWHKVKtQxlL2nc9xP2mJNBGbEXPVN1b
	c0E0hI3Ma98q8BWJSThSC9xC1h9Z
X-Received: by 2002:a05:600c:83c6:b0:453:aca:4d05 with SMTP id 5b1f17b1804b1-453a7264638mr5226415e9.31.1751300436481;
        Mon, 30 Jun 2025 09:20:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBcIwNOVZbbeCVmBSm0GSwp6bviZIHyE1JnfXVzq6+huhRLCuA9yHQd2Lb4OcWzcyg0+4Wrw==
X-Received: by 2002:a05:600c:83c6:b0:453:aca:4d05 with SMTP id 5b1f17b1804b1-453a7264638mr5226125e9.31.1751300436014;
        Mon, 30 Jun 2025 09:20:36 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c1easm168769245e9.3.2025.06.30.09.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:20:34 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 30 Jun 2025 18:20:15 +0200
Subject: [PATCH v6 5/6] fs: prepare for extending file_get/setattr()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250630-xattrat-syscall-v6-5-c4e3bc35227b@kernel.org>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
In-Reply-To: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Casey Schaufler <casey@schaufler-ca.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@redhat.com>, 
 Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3056; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=IIV2cRquSoQDpyjj3fxxhkDYmgsYRlcj84QBPmOyXno=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMpJ2epvKL1KqqgkNvm3IsfeBdK/GQ7Vj5kGz+g/JP
 HzuvPaEY2JHKQuDGBeDrJgiyzppralJRVL5Rwxq5GHmsDKBDGHg4hSAiTw8zvCHM/bZTbHepcd0
 TPsaqyd8c9JX2aGyiV17oUCzhl/651W7GRlu3/i+kvuc0IKOb351FTMWH2dpPJxivOQ0xzIFl6o
 LPLncAL7sRno=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: Amir Goldstein <amir73il@gmail.com>

We intend to add support for more xflags to selective filesystems and
We cannot rely on copy_struct_from_user() to detect this extension.

In preparation of extending the API, do not allow setting xflags unknown
by this kernel version.

Also do not pass the read-only flags and read-only field fsx_nextents to
filesystem.

These changes should not affect existing chattr programs that use the
ioctl to get fsxattr before setting the new values.

Link: https://lore.kernel.org/linux-fsdevel/20250216164029.20673-4-pali@kernel.org/
Cc: Pali Rohár <pali@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/file_attr.c           |  8 +++++++-
 include/linux/fileattr.h | 20 ++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 4e85fa00c092..62f08872d4ad 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -99,9 +99,10 @@ EXPORT_SYMBOL(vfs_fileattr_get);
 int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
 {
 	struct fsxattr xfa;
+	__u32 mask = FS_XFLAGS_MASK;
 
 	memset(&xfa, 0, sizeof(xfa));
-	xfa.fsx_xflags = fa->fsx_xflags;
+	xfa.fsx_xflags = fa->fsx_xflags & mask;
 	xfa.fsx_extsize = fa->fsx_extsize;
 	xfa.fsx_nextents = fa->fsx_nextents;
 	xfa.fsx_projid = fa->fsx_projid;
@@ -118,11 +119,16 @@ static int copy_fsxattr_from_user(struct fileattr *fa,
 				  struct fsxattr __user *ufa)
 {
 	struct fsxattr xfa;
+	__u32 mask = FS_XFLAGS_MASK;
 
 	if (copy_from_user(&xfa, ufa, sizeof(xfa)))
 		return -EFAULT;
 
+	if (xfa.fsx_xflags & ~mask)
+		return -EINVAL;
+
 	fileattr_fill_xflags(fa, xfa.fsx_xflags);
+	fa->fsx_xflags &= ~FS_XFLAG_RDONLY_MASK;
 	fa->fsx_extsize = xfa.fsx_extsize;
 	fa->fsx_nextents = xfa.fsx_nextents;
 	fa->fsx_projid = xfa.fsx_projid;
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index 6030d0bf7ad3..e2a2f4ae242d 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -14,6 +14,26 @@
 	 FS_XFLAG_NODUMP | FS_XFLAG_NOATIME | FS_XFLAG_DAX | \
 	 FS_XFLAG_PROJINHERIT)
 
+/* Read-only inode flags */
+#define FS_XFLAG_RDONLY_MASK \
+	(FS_XFLAG_PREALLOC | FS_XFLAG_HASATTR)
+
+/* Flags to indicate valid value of fsx_ fields */
+#define FS_XFLAG_VALUES_MASK \
+	(FS_XFLAG_EXTSIZE | FS_XFLAG_COWEXTSIZE)
+
+/* Flags for directories */
+#define FS_XFLAG_DIRONLY_MASK \
+	(FS_XFLAG_RTINHERIT | FS_XFLAG_NOSYMLINKS | FS_XFLAG_EXTSZINHERIT)
+
+/* Misc settable flags */
+#define FS_XFLAG_MISC_MASK \
+	(FS_XFLAG_REALTIME | FS_XFLAG_NODEFRAG | FS_XFLAG_FILESTREAM)
+
+#define FS_XFLAGS_MASK \
+	(FS_XFLAG_COMMON | FS_XFLAG_RDONLY_MASK | FS_XFLAG_VALUES_MASK | \
+	 FS_XFLAG_DIRONLY_MASK | FS_XFLAG_MISC_MASK)
+
 /*
  * Merged interface for miscellaneous file attributes.  'flags' originates from
  * ext* and 'fsx_flags' from xfs.  There's some overlap between the two, which

-- 
2.47.2


