Return-Path: <linux-kernel+bounces-839363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25186BB17B8
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 20:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAA7A2A245D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 18:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8002D3EEB;
	Wed,  1 Oct 2025 18:24:33 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DA518A6CF
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759343073; cv=none; b=Wa/CuBVM0fDgvMf+5otNTnaBUwgtH33FXO/SxBrwlOtgxGoU78kmb9pt0UEMltXpDIRi9VBdLo8fmMdOdDYyYXuqTfxv2HuwYBQRMQazdvKplcXz1FfXCLiVO0bxgo4l1mXCWBS/N6LUdfCTA93Qd5D0BsohviV1G7jQi91NnBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759343073; c=relaxed/simple;
	bh=MZIUTDUlLfJirMX9evaXHDyNYsjcHZ9WEC/P7k9Odow=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dg3o9LH/eiVwqrzQMLiNkCezliAZ4M39tKet842+qU6Pla1LOlHX45PxCHMg8LH7E4vLg1wH+WEZmNnZ59DfszUN6SNojWIEO3vhBJ59BJ6hL5tYs0Zl1/sPviPBoB4Oj1bAIDjjEEB8Ta3lVaHvqUi/OaVaUguS42F9izEiIeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8877131dec5so15532439f.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 11:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759343071; x=1759947871;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MZIUTDUlLfJirMX9evaXHDyNYsjcHZ9WEC/P7k9Odow=;
        b=KtVRdBMa+z9AA2LNOSZbOFrSxJR+w/43TxcuT+eWjvuhoSuoLvJ5URNF/14RIOxajj
         /OUl54lHyrQSwGVEQg/Qs6USWCu562zOS6H2ffEQLflZ+kvO08z9WEYCq33cbHWWtBfW
         0QVJc/6fM+KGru9hS69lMkC/BTr+QTrKBiJ02jNONB7FKQvcLozB3ZwjHStV5Up8nBSt
         42defcLAf0AhGttbe3gE2b8157Bv2K4Kp1f7koEJFP9crTf8Ng4NFROez45NV1YUaSdW
         JyKk7ZHQAc6Fezy7IVY1SgMATS18KxnuSjQn2r9AgIyczdtBRQga/SO3skGzxZF7EHJ+
         /Fqw==
X-Gm-Message-State: AOJu0YxUhJ7fEHSwfIvmiaxomNtJed8rJzApwZ7NX6DVpA77fvFR/RXS
	mupUZkvugnT9ouJMcMK2UEAoZEMt5Bfs0p3O9jd/Gs5kgcWz6vNzZ8dhuKZvu2c15WCgdWZBvH1
	nbDxOuseM/dv1rVRDiJefqZopv2misdElnfXXX/LOASA3VJ5N+6R+Ny11hrU=
X-Google-Smtp-Source: AGHT+IHyPjXHbfSeZGGx+61PuloHwRJgOQEpNFZhSVMoKDjdC8phAQ71nY//V84stsIEsmJnJNCBdQpHRfC0dKBJHDAzEjAJ5ADM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b81:b0:910:9b90:cd7b with SMTP id
 ca18e2360f4ac-937ad4ac873mr624613539f.12.1759343071008; Wed, 01 Oct 2025
 11:24:31 -0700 (PDT)
Date: Wed, 01 Oct 2025 11:24:30 -0700
In-Reply-To: <68dadf0e.050a0220.1696c6.001d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dd71de.050a0220.1696c6.0029.GAE@google.com>
Subject: Forwarded: WARNING in f2fs_delete_entry (2)
From: syzbot <syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING in f2fs_delete_entry (2)
Author: zlatistiv@gmail.com

#syz test

