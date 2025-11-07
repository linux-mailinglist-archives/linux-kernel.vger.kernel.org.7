Return-Path: <linux-kernel+bounces-890665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0842BC409D8
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 824C534E501
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F1132D0DA;
	Fri,  7 Nov 2025 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YorsSntO"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9A9329C4C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529738; cv=none; b=KKDJwk52bGHijU4yibqqAhv0jalUx4Dp8/K0mhAaF5nVF/lNiLBqy66PggWqet+ksrQ4Uv0ko5CQFA27xNIZMW/GnGnf+5F0Ie9r38S3NTsFPQkwtSYo+kO6ienfuDAy8jog+E//pZtBBq58iG4zL/HlejHUeNWR+OIItlPJyGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529738; c=relaxed/simple;
	bh=zJdrcgoALR0xH2DkImtOIpo+BNEvKbIMo9Z6qrx/plA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TccwXiCCdBi6xhrPmFqs/JfKB7XN7aMAPZb4ChSnY/jy8o8iRcspQq56JoiehlA8hc9LBVRANFq/9Qk7NJvGN2SNwUyDV/p9qjrwRYufJQcDHeqmJhYnIg4k+GyQv4ylR1vQFs6ochRKh5KCRVWfZih+61fFlQUtbkyF/i2mV8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YorsSntO; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7a9fb6fccabso772927b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 07:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762529736; x=1763134536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/W0MVeUMNs9wcZldJ+mVuCnE4W2Lpw3nds3hMNg6jvI=;
        b=YorsSntOgrY+2ojMZ5H/ZumsKqvQqc9DjW0EEHYG7LhhndVeei5St8NIIUXUNbdBmL
         BPxIEfYTVORjnBBYl1oWQw6lGQKqA+Cd4CF0qXgX/pnLmSJoTTFVvv/ZRdKih9eHdvWM
         fyjzxYC0eIcz+4UDLjvVYI6kmvzW4KbAUW+2YjzwQyRaUdGFJd3TamScgfXHYEAYSg9+
         +00beu3aOOF3wro6YiQc/RhGkb+7jJ5N3wnYC3bTNhJ5OBvxv/UyPX1BccBWhl0VZb4d
         JmkFeyYc85x4wlslbbYVxALIMDqeFphCMWOrE6k7mgefz6/8MpmSjd/HYAxpR15NWcRM
         3mFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762529736; x=1763134536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/W0MVeUMNs9wcZldJ+mVuCnE4W2Lpw3nds3hMNg6jvI=;
        b=b6E+hHKE6DgLcXUybnJ8ZUcXhZqVmR6dBbkH+FyabaWXkNUfz50gSt4kMxT/pAWpCC
         Z8tdHLExfo78wgW400/UmGbaZyv/f+JLrD5HKkEcy2DwGe9sLkSDKtjF0vZGJH14elDK
         f9Bhn/Mujgwh+CFD6t49vh7fIp4op1rEo8pvRYPchCnuRTtr7xUkuq2ISMpGeJS/nRek
         EZVR9NpJc4aJDMlvnT2rMjBFMk5y7j7AFOc7ydu3RmyO5JFGLPu/Av15njLcfVgsr7tC
         jxYso9WH+hfIl8m8X5ZcOVu2zzUlDm2eRXNgAPZKkkQTUsoRM3KxnQJ6z9yNhVMyE0+s
         i/bA==
X-Forwarded-Encrypted: i=1; AJvYcCXHsl7jk2vc7Ymblar33ZBsH2KqOZDK/UfGhLFORy9skD/+ELt5+hwvGhj+23eagzxowdkYIq5lbhTXOxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1CO/GwcoqJOfRcLKOE1vZkLu0XiUSjMMoAQDPBM76nqHTXvEa
	lENJYTn4aKAL/U7i9py8ebGsIv9BfGk+Uh2HMp9b9q5wQ42ycT24sGYw
X-Gm-Gg: ASbGncuLyRpab7hfqJ8p7jTEN7xnJ8Ks5YJgDGYsIzomPXipBetU1CSw0tifbW/u5Sx
	S0h8yerUPVNmDr8CchOewlz6PcPQiaYP4Z9yG1ksiu7oBPCT+wb1+DqRuefPHD7XvYVInP4uWAc
	Gtnph9nSkuHzmwzJeyIis/+kG+SHIRrcmZrshfsahwFe8WyzxGlp80guSM72sTN7mfDg+Lz6+I9
	tvsXGejJq4ahvd5YaFCmwFPLkWx4Nf9c5RkBlNF3x5vLeo1M83B1PnAu4aTjPUpzOGuFGP9KSgV
	McHTc7VI46h7Jhejn5NWvwQU/bZq+CqveX/ktU6VYjVWRaaE6QsP+F6PLGC87iVIkkLBJzOhcuW
	ycRFMIc8BD8/qyE0IY/3Flz5BFN/+Ed5AN5LYqZGwzSE1QpBI4KJAF5YI2VC6jN+c/2AcEHQf8B
	0yIqv1PQULubUji5RM/wr9HcQwWLb+6ZwuupKq4iwBFvkVpLDPxamfTtwXnolF
X-Google-Smtp-Source: AGHT+IGLW5hrLEauNfqtWP7rMnZ70eoI+w9zgxcAeBxmGbfmB2VZwOYD50GSPrR8QqMdFwFBfd70LQ==
X-Received: by 2002:a05:6a00:1ad1:b0:7aa:8397:7750 with SMTP id d2e1a72fcca58-7b0bbef7e14mr5320351b3a.12.1762529735770;
        Fri, 07 Nov 2025 07:35:35 -0800 (PST)
Received: from carrot.devel.local (i114-180-53-102.s42.a014.ap.plala.or.jp. [114.180.53.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9634f56sm3360011b3a.4.2025.11.07.07.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:35:34 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: update nilfs2 entry
Date: Sat,  8 Nov 2025 00:32:49 +0900
Message-ID: <20251107153530.9023-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Viacheslav has kindly offered to help with the maintenance of nilfs2
by upstreaming patches, similar to the HFS/HFS+ tree.  I've accepted
his offer, and will therefore add him as a co-maintainer and switch
the project's git tree for that role.

At the same time, change the outdated status field to Maintained to
reflect the current state.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>
---
Hi Andrew,

Please add this to the queue for the merge window.

Viacheslav will help with nilfs2 maintenance (upstreaming), so change
the entry in the MAINTAINERS file to acknowledge this.

After the next merge window is over, I plan to send nilfs2 patches to
the mainline through him.  I sincerely appreciate your cooperation in
the upstreaming work over the years.

Thank you.

Ryusuke Konishi

 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46bd8e033042..d5e2c1524a96 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18254,10 +18254,11 @@ F:	net/sunrpc/
 
 NILFS2 FILESYSTEM
 M:	Ryusuke Konishi <konishi.ryusuke@gmail.com>
+M:	Viacheslav Dubeyko <slava@dubeyko.com>
 L:	linux-nilfs@vger.kernel.org
-S:	Supported
+S:	Maintained
 W:	https://nilfs.sourceforge.io/
-T:	git https://github.com/konis/nilfs2.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/nilfs2.git
 F:	Documentation/filesystems/nilfs2.rst
 F:	fs/nilfs2/
 F:	include/trace/events/nilfs2.h
-- 
2.43.0


