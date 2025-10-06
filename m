Return-Path: <linux-kernel+bounces-843010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9D3BBE319
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55523189332F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516D02D0C85;
	Mon,  6 Oct 2025 13:34:08 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC532D0606
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759757647; cv=none; b=YxGzefgtgFr1Crvoc8mk1ZNE3v4Eu7nxVdPtTqouKGCl/uUY/U5QDx8ggNtNiLDAqwwcdueLlUXOi79YMT3HvYJZRnrLaskqwRtTA228SGdIh75m5PmGxxmSYGkAXV9v9pEysOzZzL15lsA3gAXPX/8lKlAsa2AuaaVm76oKc2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759757647; c=relaxed/simple;
	bh=TL5jMOTAeFsRvHAwOtmEOLeCIjnhJJpPxhu6/rUezI4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rItKxAR99cvmEjEFKL0LyB52yW9nnVgnR7JcjoCGNF7JYGP7Q1LKniTxfUpCnjIFqvpnJXWyae9as8F72ICp70rwPVefRFfBde359yaBxyNoYaK7GuVm5UAZQVg9b0ljNDn/a2PXPJxKft0LZhb9komCupv+WVxxfCpc77CC7sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8ea63b6f262so1009807339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 06:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759757642; x=1760362442;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TL5jMOTAeFsRvHAwOtmEOLeCIjnhJJpPxhu6/rUezI4=;
        b=j5VoEg8vDlWRsLyoK+UF7V4YeBfJXd9zthWp5//zBk0EtNYwl/N0h4lIJdvpSBdt4M
         XBgC76WbvtG0ilcJXVrZ2MaIwy6c6zV+vX7zzfCNTK8Yf89Px6Qklhviet8cAofKB8lD
         gmdfWyIsPMe0sKyD0J9y5p4ruyv+S+vE1mi3boPRFTN73xLLJP3SQ7CFuKq3+/YigK7h
         pVQb7eWxD16aQvD2t6uhcIB0hdLL90cXMAoLU85v519t2YXxATuxfTA8NtBqcTJq1l4J
         FZXrtaEtWcOkcszC5GF30hhVtLYKKVUL9sGmhk+hVY/EMP83vFVIiwQjachL54z6f9m4
         mvPA==
X-Gm-Message-State: AOJu0Yw3PohGYks0KMARAn99GCo96BIDYD2L3oUCjD4VAatXj7sXRSgc
	zZeaMwpTsaIymdb75o97RuOsIps33UWbt/W3bexLcRkFJmkyxzX7K4xTTi4X0VjNMw2Fl31Xhd4
	gXLiawm7o1lkG9dGmPGNY9uM9qgzocHn3vE6/2L12gKY2/hdbsUTFDydahuw=
X-Google-Smtp-Source: AGHT+IGCUSuSmBAJEVX50qgKAJNt4+VcNyxwrjZ7J9gp2hf+lCTLn3kZPMvGaPuAtQnG20oTiH5ZLZukni59C6p2PDlLNGqN/MjY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c244:0:b0:424:7633:9e72 with SMTP id
 e9e14a558f8ab-42e7aded691mr175835595ab.30.1759757642466; Mon, 06 Oct 2025
 06:34:02 -0700 (PDT)
Date: Mon, 06 Oct 2025 06:34:02 -0700
In-Reply-To: <67afa060.050a0220.21dd3.0052.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e3c54a.a00a0220.298cc0.0462.GAE@google.com>
Subject: Forwarded: UBSAN: shift-out-of-bounds in sg_build_indirect
From: syzbot <syzbot+270f1c719ee7baab9941@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: UBSAN: shift-out-of-bounds in sg_build_indirect
Author: kshitijvparanjape@gmail.com

#syz test

