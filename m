Return-Path: <linux-kernel+bounces-747253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11951B1318A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 21:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474701740A5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 19:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281122253E1;
	Sun, 27 Jul 2025 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHzIN8ob"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCB5194A65;
	Sun, 27 Jul 2025 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753644795; cv=none; b=kHWkax1jTItFQCS3ZpKxN1jdHzh9ELcXkYGLo8D+Hu367Z9vRqtGRkucVXsrygeKiiNSjio5gv0aSVi7nlLLgLey5F/qDG57ZHArXdSJqRBmd8mWj+UXY5QaR/zWBnWAy0sf6/H4z+04pdp4bHXCvdq1shjsuwQZogY7JkqTcAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753644795; c=relaxed/simple;
	bh=6KdbDjlU7MNLdd6vRI7BRsrwL6xqrrZa1ld4+GRsLhQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oKsgxaUmWFh7ybrQ3EtjwV9N14DVYvIOFSDl4XiflAxR6O34tsfa145pAHUEfBJZsowctU99H1GCl4Nu26GM8f5S27rQUif5FLUgQoQQgw5Idh9sTLzKE62Xqzb5+r5I9+Vv8YOFTWaoUqBj4bxQzs21F41/nwZb/aau0fgNn0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHzIN8ob; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-707453b0306so5087756d6.2;
        Sun, 27 Jul 2025 12:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753644793; x=1754249593; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6KdbDjlU7MNLdd6vRI7BRsrwL6xqrrZa1ld4+GRsLhQ=;
        b=RHzIN8obtTUuIhCNR/l/ymg5JtN7RJBFXPHi0Bgm/NbQkXbH9nkpUvKLlnorcu2/jO
         96tG1UMh7lR67CLERCTRYAA6GYNa99YVa42AequCnHoFRbixn381mQ8vPP4YmLbaEqlW
         2Q1BKKYq1A0LXXSd9/tBi/IJ5XavsHcpjrFpobAAeXH9cyUU8jNgjPF6AODyF+43Ojak
         HEpWjXdfF7/3/fHqWvtAl4vJjO3j/3LcYD9++1l8ruxcpI6MU+zsEwSbELNDRvXnB/OP
         +QQvSwDceEI4zKuRZo6df9KVxgPDFuYbXcEKx3Om8Rmsz1SNOtndkw8O8esXIRBFBDry
         pZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753644793; x=1754249593;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6KdbDjlU7MNLdd6vRI7BRsrwL6xqrrZa1ld4+GRsLhQ=;
        b=OHIxFs00MgSEa+NE2JIpnPUI44Xtlm6ARbOSgSmxX6FhrJkZrWemFVzeuqAyFPpBSx
         5itjsTQAu1mPP5A7j3Vq3G3o38H+n3VhHej1zUq6bRVQqbRpuXilu/0DB4doj0ordkZs
         TjjlGCqHACefRWudvXaQRqL3laFAbF2ZO/4foMN4q67pL5TRbn0Gp3n2V0CTvcbsjmud
         UR3ftS9BtIKU2OgDX1ZL/0PhyMqKpOQ0ij4wxrLBdhLrSh1zSkE3peArM6Piymw9dVzc
         EjDyAFkWboAb+n3iszSxr/DgvyuyDbU/pwbGfXW9Uv9Ka4NybfbZdETgp96guDHWNJBk
         iuDw==
X-Gm-Message-State: AOJu0YxtWqRScioOPm/EPMicpJeaNGZKNoacs6nkRfA4VFgzXJvp+7qq
	C0sNwBYOxBvMliX66OXPv5jkaVlrDxXWxIo+clTVVnIIeMfcSMr8DdzUsXbIe36NzY6esUlqkRA
	aUkALmzpx7FAZjB/3iWE+L64wGF1AlEnM+xqm
X-Gm-Gg: ASbGncvcEFo/uZTlHwnrY4BBNAYHUc3EFx8v5pa6Psl4NMgKIx1+UoAKyQkg+9bS0fQ
	3s4ms0fCMtoph3BEI5x2zmRKf+vsmcczHOgW4t5Vq2bNJ5CWNGSoeRf8YasJfBJoiyEmoo0UYJO
	6DSZ9h5Hm8QOmIZ9283QIq/A/UlI1JjZqa7XKubM/f1KPApOoDLAqHsayW6PdKVOv/GR8WH4TpF
	3wlzngiBtCyp56EMmOe+AaFHNv0iL56nf7CGi4JbA==
X-Google-Smtp-Source: AGHT+IFK5tEPWCumGhnFE2IwR7NP1qZVxV1XN/ZXaGRFoKiTvVk2rPmY7RiFxZZzTyRWv4Nt7/oPzNJWU9gek7lFK00=
X-Received: by 2002:ad4:5d62:0:b0:706:f3f9:8a52 with SMTP id
 6a1803df08f44-707205aa5e8mr115361966d6.29.1753644793056; Sun, 27 Jul 2025
 12:33:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vedang Kandalkar <vedangkandalkar@gmail.com>
Date: Mon, 28 Jul 2025 01:03:02 +0530
X-Gm-Features: Ac12FXzVbkZ1vZQB9x-4PwDODBFKwAXJV5vLsf35dCKl6ekhvsw7-l2URHvb3xg
Message-ID: <CAJSSbgCRT-EcQTdTKof_gG5eBD1eYZKEFC_9pdQsaCiXx9yQHA@mail.gmail.com>
Subject: [PATCH] docs: remove broken overline from sysctl/vm.rst
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From 098513ca1d41c0c69f3956a6d22f34aee452afdd Mon Sep 17 00:00:00 2001
From: Vedang Kandalkar <vedangkandalkar@gmail.com>
Date: Sun, 27 Jul 2025 23:38:12 +0530
Subject: [PATCH] docs: remove broken overline from sysctl/vm.rst

The overline above the /proc/sys/vm/ section was broken and not
following standard reStructuredText conventions. Removed to improve
readability.

Signed-off-by: Vedang Kandalkar <vedangkandalkar@gmail.com>

---
 Documentation/admin-guide/sysctl/vm.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst
b/Documentation/admin-guide/sysctl/vm.rst
index 9bef46151d53cd..8f3875d68ac8ea 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -1,4 +1,3 @@
-===============================
 Documentation for /proc/sys/vm/
 ===============================

