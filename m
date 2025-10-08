Return-Path: <linux-kernel+bounces-845437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BA5BC4EA2
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FF2E400A03
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B7525D1F5;
	Wed,  8 Oct 2025 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bf1Sk55+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ED124EAB2
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759927469; cv=none; b=fOC1k5sq5axoMht8j4cFHoOu+Q+t6TiI9KyPmHFtKAE7PIzrKT4Um+pAgVDIAx3Pkhc+WVAbzVpBQircOZsqedg8zSiMSdrTpraS3Fvq4Gbo5tetugsoN9vczjSaNXXhn+yYX+BaQ0WytfmTJeqDYVBrA0EfK1IBUse3uPuOk5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759927469; c=relaxed/simple;
	bh=J0rcHYqkXUQdeIfOqOASx3V8jB86T/gKqv9OJQeeD7I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fgBhvcf/KfBhD6hXV31+9UJE44BfZl/Wt6HzUY4ZrsmbeRCW8aZVT7yqMG+XtNE8QQI80FGp9KQ1ayF15uVYpUwcqB7xxCtktd0TRHIytxnboZKfqQm+OZmdFozyT0mOdyxBuhOuCVze7Ms3O11NFmhbdGnIz4VBcTrEZ+iKGCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bf1Sk55+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759927465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rVKpcwPEfSYv/1RGY/1E+W+n5PoXfbCIlc7Ok0Wkf48=;
	b=bf1Sk55+XL/oh0WYvR9gCD1SBryxAxNQY6vnDTaHRtk+0Rh396Bnch4d7pY1YpDexuBZgy
	XDCGzjTRruF31I2PIuleF71+PywC0oluZHL3r/K21aXpmUMRgI1l5U0XoSagwWYS9sW4rU
	1eRyoDcpJtWlRa7XeUV0ne7wJrfUnlk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-tlRcA4QVMTarfwO83w0pmQ-1; Wed, 08 Oct 2025 08:44:24 -0400
X-MC-Unique: tlRcA4QVMTarfwO83w0pmQ-1
X-Mimecast-MFC-AGG-ID: tlRcA4QVMTarfwO83w0pmQ_1759927463
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e31191379so43093995e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 05:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759927463; x=1760532263;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rVKpcwPEfSYv/1RGY/1E+W+n5PoXfbCIlc7Ok0Wkf48=;
        b=XYcgkZkehu9Rg1LqL1jvSWwsHADWm1Ae22aZPpz1JOjmNWaUomf2W9LokZeiWTfQlx
         2dn9FTuXCJ0PCdJNwz5H0krQ19hlE4+u5ifLhPYtO5NPx0bOIwAdSWfxrukb1FZcVe6y
         BPCDQ5yYK2vbq6Yuilhv9xJUb0KaraAnNaHc3CZzj1qXPuacfEXaWFA0UwPtz5Gos8Tn
         VNpkD15Vt8u85P6OLDEUiADasx8sowB9eVBPr2bmXGmioLAMDVQXzvXIOaJGJIAc9k5l
         Qh7u4btXnh+6kYRm090r4VWTqCKQAVtucLW7kh9X7jx6osa3ELV1YFbtURBcF1FpucJx
         jiXg==
X-Forwarded-Encrypted: i=1; AJvYcCWVFObkyaJUga7wMSiKhpUZMBRxFXNkSuCO48l7TuHNYHEZRI/k6aLK3zzHsEhW6N5M9/DLkYCfklYtm4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTzjIKcru6IalaS29qowI4+LjXPWZbF40V+j/TpF5GcyZ1an/H
	4BcyTOszr4bCxukm5Fdd5hY1kJVImBJheVdV1YF/GIBTg4DfN7H2jdgXj1rKb7pjfOlKI5EWxOs
	BWGtmXukdMM9pOQh7GV34wpkBK4qkZFvPXo/ykzXTI/oFRLcJQ6mij5TAFMVM/nJm
X-Gm-Gg: ASbGncvP9jAZKxpRWXMiAuyqnA+N/p3Qojaehysa0tThCM/GgiXr0MgTFcgdtNtFR0+
	lPYCHFVRZftNYOo3xSIY2esQKL8F33YqLUqX69O6srWxtc3vXAfpOzZLcsbzaUDLgp74vXNp3A4
	+2mbzIlm0L4xTPrLcpGVTvGhWcdFSvXPWCN36J2OtJAgUdugbYadm6rNdaCaQ8/8zY8lt6u+nC5
	n1mzsGGpXk91lhKfgCaVQBBpHfnitTf6jypdWG3IVBSQbTFL0jW2KmRQiGvC43Uvf5tudQW/eBo
	q1oVnasIKow5NOp0vJHknw3oLVRGuqd7zSTZP/vyQtPf5Q3eojRWZCQZfn/5GQfjdGazrJjc
X-Received: by 2002:a05:600c:a08b:b0:45f:2bc5:41c3 with SMTP id 5b1f17b1804b1-46fa9a8f261mr22409205e9.8.1759927462679;
        Wed, 08 Oct 2025 05:44:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpZOod60VGpL3LxeIqF3d6Uhr5luUS9rguzi/Rbgfb5kIOkUA+4Z+I6w9G9qetBDplM+qOKQ==
X-Received: by 2002:a05:600c:a08b:b0:45f:2bc5:41c3 with SMTP id 5b1f17b1804b1-46fa9a8f261mr22409055e9.8.1759927462212;
        Wed, 08 Oct 2025 05:44:22 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3d438fsm13918765e9.2.2025.10.08.05.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 05:44:21 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH 0/2] Fix to EOPNOTSUPP double conversion in
 ioctl_setflags()
Date: Wed, 08 Oct 2025 14:44:16 +0200
Message-Id: <20251008-eopnosupp-fix-v1-0-5990de009c9f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKBc5mgC/x2MQQqAIBAAvxJ7TliVMPpKdIhcay8qLkUg/j3pO
 AMzFYQKk8AyVCj0sHCKHfQ4wHHt8STFvjMYNJNGdIpSjknunFXgV3kTLAbv/Ows9CYX6vr/rVt
 rHygVUMRfAAAA
X-Change-ID: 20251007-eopnosupp-fix-d2f30fd7d873
To: linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Jiri Slaby <jirislaby@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1060; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=J0rcHYqkXUQdeIfOqOASx3V8jB86T/gKqv9OJQeeD7I=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMp7FLE2RfrRMMcBBwi375nZTs207zlW9vyDlsSc+o
 zM1g+PooiUdpSwMYlwMsmKKLOuktaYmFUnlHzGokYeZw8oEMoSBi1MAJjI1npFhocIZ6/Xs+9t/
 8C1U0pvbuvEn06GC1UITm9iPRGv5xX+7zPBP5/f7y93XzJStluR1KO9rLJDYMdVD96TI7sqUiw0
 6Vyw5AUdnR50=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

Revert original double conversion patch from ENOIOCTLCMD to EOPNOSUPP for
vfs_fileattr_get and vfs_fileattr_set. Instead, convert ENOIOCTLCMD only
where necessary.

To: linux-api@vger.kernel.org
To: linux-fsdevel@vger.kernel.org
To: linux-kernel@vger.kernel.org
To: linux-xfs@vger.kernel.org,
Cc: "Jan Kara" <jack@suse.cz>
Cc: "Jiri Slaby" <jirislaby@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>
Cc: "Arnd Bergmann" <arnd@arndb.de>

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
Andrey Albershteyn (2):
      Revert "fs: make vfs_fileattr_[get|set] return -EOPNOTSUPP"
      fs: return EOPNOTSUPP from file_setattr/file_getattr syscalls

 fs/file_attr.c         | 16 ++++++----------
 fs/fuse/ioctl.c        |  4 ----
 fs/overlayfs/copy_up.c |  2 +-
 fs/overlayfs/inode.c   |  5 ++++-
 4 files changed, 11 insertions(+), 16 deletions(-)
---
base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
change-id: 20251007-eopnosupp-fix-d2f30fd7d873

Best regards,
--  
Andrey Albershteyn <aalbersh@kernel.org>


