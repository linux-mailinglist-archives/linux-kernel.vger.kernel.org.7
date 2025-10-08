Return-Path: <linux-kernel+bounces-845439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 180CEBC4EB4
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB6B04EF85E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4632269811;
	Wed,  8 Oct 2025 12:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HpTP8yIZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DEB253B59
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759927474; cv=none; b=TS+OQdYnARlDxyv0CzbBG6SkSIsw/g8bQpP5IvwaBC3dvim8jDyGwBGcbSVj6kAMKHYPR/eyTSKL29FSGcDkiEC4dQSvctJP3qFwHzKpmxkvHYXORaOzp4HaXXxAxHyIpK2q7owCaV59hE1f9DBx2EksTRlg2D/f7yrTgUAPDT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759927474; c=relaxed/simple;
	bh=0FQzczq+XvPIcLSgmN3fW8/Mf+a99S5LM/p3VLvLUUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d9OOM2V4I+sxZSKz6DUowsWa3ygf5cxHFAnzqmVTwuJ1RFkj7LBIL8aqaURx6sgNf1elk76LEkjGVLUq8Tln0fFwAtvtVctJ9wxsMfgdNKdqBs2hXPnTO1PF9Jor2vSB6YIyEWWfljVbqbMJrHO++DeBpzNCfeC1ocRtqqGcZlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HpTP8yIZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759927470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTuvQMGGyHVj/GABY47oNzO2RJy8snMcE51C98ebSFA=;
	b=HpTP8yIZWcjqQI2KKV95aoP7teZ7uYi+Mt6IH60k5JUUgbvukdGgCs1Of8hCI8mGKNnvwe
	Kqizn8GI32rrXT1MgAtI2peVvbniX46PHCrLk9ctyVTObEu+gwplUnz9kgjihEeic1+6jC
	BBDzMGJMPzQK1vnGZF/X+8O5eGCGyUI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-4cwMgPUFM26cIQE9EsOP6g-1; Wed, 08 Oct 2025 08:44:28 -0400
X-MC-Unique: 4cwMgPUFM26cIQE9EsOP6g-1
X-Mimecast-MFC-AGG-ID: 4cwMgPUFM26cIQE9EsOP6g_1759927467
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e473e577eso38798165e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 05:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759927467; x=1760532267;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTuvQMGGyHVj/GABY47oNzO2RJy8snMcE51C98ebSFA=;
        b=iBWiBO/Um07wZPYuWhR8QH6GEBp9tMXO7Y637H/JGo1nGOOWp1Gb1/UECwwwq3SReO
         bQ21W37LtE7lZD7lUn4dW8OMPLOVQQMHZ1wbaTO3YQ+nxYBUiNi1/hDH5UL4Y9FOkChU
         Ewmh6LzCC6e3WI3NVXlKbubM3tWgH9Jjo6aleN0Hc3frtWfSFzPvfqwuYR3r+IHgLB4w
         uitiz42wLcu0DHtx9hVuR5heO/Db8sZPqn4Ykj2/JPI9Sf2YIPjv7pmFwOZlpj8HXoiE
         icV/GngSm/BzFurPpQ6ftYF67bVMjzalTwH6fjPm5A7V61mqazHrq866VcCiqAoelEb+
         b+0A==
X-Forwarded-Encrypted: i=1; AJvYcCUyHC9B0umvytjqDUqGWa50GEGErvbtijWu043N6Hb2pY+PsVB6Q6yVByDm3GAEqbQ2Tk1kodwpm/v9DXU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/T6zVl8VAJY3acv7c6nEa6A/jHIz6bprPRxjfXJwVg4t5bP0i
	RTH8kzhPSwnjV7d9d76SuY0DnmyYuNBiuRA/m8Ltus4onf5Kl4XOeJOgYx9V9ENzEeL513kKTqd
	B6LS47WI1Z9QU38LVu/a78/hLWDRFXVth/EVnbBKLOEh6XTk2or5xunxaddR+5pX4
X-Gm-Gg: ASbGncti5VaCAZB0YkJeZDE6EB6gfWRhCi5sivpy1NUep+7zmquT222aWYhmP+e59M2
	wSZ3i69eUbiy7ijn5a3ToEYXi3dIK/shabznYSkIbiDC/Ebd03tqtSgQLN/jyPOARUkKQXu0h4M
	hgGXBLEwdGAjtbvajksydW/qZRhxsQMMcUeAFV6BeFaF7BMUzf07x4ZYjiL9W/mXx6DabaaDqLA
	DhOU4Z/N1Jcd/D0APrmPS5nt5TVGXk6N7vIEFomsUVJqTmAU3imJcD6SimPisKxTx6L4OXCO7bw
	S/0FxMRvwb2o4elAz5/rqxqQ04sR7lL/3n/KfiRKO9MoPj3ZwOBi1uJyaiLHWkgHG1EYj8JY
X-Received: by 2002:a05:600c:4753:b0:46e:1d8d:cfb6 with SMTP id 5b1f17b1804b1-46fa9af0621mr20360705e9.19.1759927467228;
        Wed, 08 Oct 2025 05:44:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUOOWjGZbNdj8gMQY80gtaJEpiEmEfUTkvwjILGRLj8xEez7HmT/bGwpHIikuJuXE2VGR3WQ==
X-Received: by 2002:a05:600c:4753:b0:46e:1d8d:cfb6 with SMTP id 5b1f17b1804b1-46fa9af0621mr20360455e9.19.1759927466628;
        Wed, 08 Oct 2025 05:44:26 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3d438fsm13918765e9.2.2025.10.08.05.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 05:44:23 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Wed, 08 Oct 2025 14:44:18 +0200
Subject: [PATCH 2/2] fs: return EOPNOTSUPP from file_setattr/file_getattr
 syscalls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-eopnosupp-fix-v1-2-5990de009c9f@kernel.org>
References: <20251008-eopnosupp-fix-v1-0-5990de009c9f@kernel.org>
In-Reply-To: <20251008-eopnosupp-fix-v1-0-5990de009c9f@kernel.org>
To: linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Jiri Slaby <jirislaby@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1018; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=0FQzczq+XvPIcLSgmN3fW8/Mf+a99S5LM/p3VLvLUUI=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMp7FLGXrP8A6vbUxj0FJYk7QpN39id7xEkWd89QkI
 zpFkg//d+woZWEQ42KQFVNkWSetNTWpSCr/iEGNPMwcViaQIQxcnAIwkdJChv81zi23ZYUvSooz
 rV8jnbo2JlSBw+6ARlfjho/CMi9lDOQZ/unft+y8uohbU15J7LPhvrUve3LPuzVyGeXnnAn6cq/
 9HjcAeUxC6A==
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

These syscalls call to vfs_fileattr_get/set functions which return
ENOIOCTLCMD if filesystem doesn't support setting file attribute on an
inode. For syscalls EOPNOTSUPP would be more appropriate return error.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/file_attr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 460b2dd21a85..5e3e2aba97b5 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -416,6 +416,8 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
 	}
 
 	error = vfs_fileattr_get(filepath.dentry, &fa);
+	if (error == -ENOIOCTLCMD)
+		error = -EOPNOTSUPP;
 	if (error)
 		return error;
 
@@ -483,6 +485,8 @@ SYSCALL_DEFINE5(file_setattr, int, dfd, const char __user *, filename,
 	if (!error) {
 		error = vfs_fileattr_set(mnt_idmap(filepath.mnt),
 					 filepath.dentry, &fa);
+		if (error == -ENOIOCTLCMD)
+			error = -EOPNOTSUPP;
 		mnt_drop_write(filepath.mnt);
 	}
 

-- 
2.51.0


