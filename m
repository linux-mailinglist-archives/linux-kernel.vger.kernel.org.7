Return-Path: <linux-kernel+bounces-890858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 758B0C4130B
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 19:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2473F1886C54
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 18:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EA8333421;
	Fri,  7 Nov 2025 18:02:36 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76588326D50
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762538556; cv=none; b=nw+EYF643/Vnjf8ugCyhsX3GAtFIrGGEyYkyYaLHXycRokkeKFY6UMnCLZVhcm26CR4lZo27BXIlny1D6MfCwoVPHnx5QNpHEX7i6iWb1/yJFXYgOeNgyaQVS3/AU+5J1fg/oawsZK36wmGZBMOEt5zFQYo3H1kumrVYXLcvKqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762538556; c=relaxed/simple;
	bh=xCTrRG7bySCeTm+7Tvph5RGd90vHmi+5IH53SjcnTXo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lF678dThUSNsX644Ko1ZHq/UkxnbNKqKbF8QDfhU6sxkLuDzXfyGdxYw0p03YpNpVoAKezSRFySb5KjngOnJKy4Ot1ORlxNfj8bgycX2AIw0tZdqLliCquGNNW0DcaMzvOmWiWUprKk6b79Y/cYuBByhs90L4VNJ8O4xyQq+WmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4330bc0373bso8553795ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 10:02:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762538553; x=1763143353;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xCTrRG7bySCeTm+7Tvph5RGd90vHmi+5IH53SjcnTXo=;
        b=pjoSRYFwrMOMSYQEOvIAovkDZgVCsR+F4WhwJuEIweD0Y9NzBkEfUyJGiM4nedFZdi
         lKxQ26CskSE83+yXOPlBC/VojLLUTwLgmMeTLf5B02OPBp+z/td/IH/5u26R82Mm7l6r
         ccFkTEoQjcAB/wrlUdmKlgtUKb9wYuBOORVkRFZ2fnqCALlQflQ5IR1jC8mT+Q5yWuNR
         lhUcFBIX3q3SvBdjIew023LjslcGgdFV6qcpff508ODTEGVFxoTtqKofb8jlnmzvlDVi
         at87QGhytU6THbA04TyWEBuTrsgTpThUk/4mjzJ0YSvDo9Z13TuJ+djsAXsvezKYEs7n
         UXuw==
X-Gm-Message-State: AOJu0YwlT/z1RkZ+L3//hbsb2DYEDcqk1Gml0aICIJTsAQDUylAChtQk
	SzBC/57Betd1OdZ4W5miP2i4nFtcPiIgfv7M2xS5lSpwMu1wFBgXn+yQt8JzbI9VwKk1Bq6wWwH
	cunUEc+JjICKDXrZTEACs/Ri/xaC0vcC24uRLCFEoYOui6hbSyBIubjbsnSc=
X-Google-Smtp-Source: AGHT+IE5YJjIcPuwtpuCfmKePMdG1ZkWHWtvzWQQaWuGaU/qL4XtXd5we6rzHdaELspbGDBxPv3T7sGTVYTYxGq8OkmV3OUd1/jZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c88:b0:433:377:ab8 with SMTP id
 e9e14a558f8ab-43367e46d69mr4613835ab.23.1762538553638; Fri, 07 Nov 2025
 10:02:33 -0800 (PST)
Date: Fri, 07 Nov 2025 10:02:33 -0800
In-Reply-To: <67afa060.050a0220.21dd3.0052.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690e3439.a70a0220.22f260.005a.GAE@google.com>
Subject: Forwarded: Add validation for scatter_elem_sz
From: syzbot <syzbot+270f1c719ee7baab9941@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Add validation for scatter_elem_sz
Author: kshitijvparanjape@gmail.com

#syz test

