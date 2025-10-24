Return-Path: <linux-kernel+bounces-869491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4410BC0800D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 22:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24AE93BB29C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE4A2E62A1;
	Fri, 24 Oct 2025 20:10:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0662E2F13
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 20:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761336604; cv=none; b=p0Ml16A93VqxepZJUdSP6Omg9Ei2k/ZbgSFolDC1LfwiG0YV4dsxrMHx+kf0S4Z6fv7aJWBqCCaq0V2ePgEk8nGnIWlwRSMHx9fxK+hpNJKpZDwX4WZDF4yysOoEyAgwuwvhTmzbeGJch1Rkue6VeMtGOdFNvQ/1ZJUaJIFo74U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761336604; c=relaxed/simple;
	bh=5e1z4X0GXfz+sXjtmG8f7llpCLE6qws2zHAV//pxovg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EBxolDRjK5TKTLRcuHbMFljjVh9O62WoN/Hmhb2ixbq0xdQNbc2ZbRiLtGWaDMgPjG2uYwKYSrDwtXM127EyboBjURae+wXVFcwIRd/XzimjMi/NCZk3INDbUWN2CD+YxfniPuomHg+BS9VCntCsnW/1PrHPke4cZHMLeJ4edd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430c8321bc1so34239085ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761336602; x=1761941402;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pD5EQC3sKQgvZOVzVKbz3HY4CWX0jjmoHtrgq7Vyt5g=;
        b=JL/8wOy4uFdqlFaXEmheyTSrBEzXBssFdOzB+8QewusT1lBY+cZn2INge9tsCKY5st
         gaqfxMspWbEPfv/ddBmHNuhJiJkJWgUieXlPzmHk0OsgQGSyBomIhGakRA3BlkeIqXE8
         9XJSutiEkWaW6308ubsmai/psJpzgFrQMt+CJi7Cs/xYhb3AeDCSaqoOUg57ms8ICGfy
         D2HglVe/em+4Qz9xmrcrpd7UHqA1QJe/GS+7A8hl7CguRUllcxjdV6KOUY2SPXUu3xsm
         UC1OsBYV+IaqovhdI4lVGDNw5wIyqKUx2ujTvHhpuR7ymeTQH7SpDf8F6QIhUVL8SlPb
         6HqA==
X-Forwarded-Encrypted: i=1; AJvYcCVLSZ+5oFHyI4MLFJcYmc8WKZkdzK2h2ramAP+VKi6kG9pQGcPdSxTb/tDTTPp8HZnpTma30Cy/lPUVt+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVUZgOvFv77CBTeaJPUqTIPMtrTTsjitlGCzJ8/K/lGdQn9vg2
	yl140B6P1rifOXXnljCLF2gPd3gzTfC/Nv0o1glQU5be9NvUd2OIgRUWufvkmxSDrDDMYP3pXsW
	U5gb9zS4v3/nAHrzXRfS8WAr9VK31TVKmztwGGxScrdvVjrAq8va9F4Xv/ks=
X-Google-Smtp-Source: AGHT+IGlUpe7cydcYsCSWlW6XihJFInJ5PrrM/WDK2B5vlav5c+q5ILM6EBm0u8n69E78Yxpsybu0+hW5MT50ZjVBupDnAav8Nfe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda3:0:b0:3f3:4562:ca92 with SMTP id
 e9e14a558f8ab-430c525f520mr220412755ab.10.1761336602321; Fri, 24 Oct 2025
 13:10:02 -0700 (PDT)
Date: Fri, 24 Oct 2025 13:10:02 -0700
In-Reply-To: <aPvQHxLIVpMykkG5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fbdd1a.a00a0220.9662e.000c.GAE@google.com>
Subject: Re: [syzbot] [kvm?] KASAN: slab-use-after-free Write in kvm_gmem_release
From: syzbot <syzbot+2479e53d0db9b32ae2aa@syzkaller.appspotmail.com>
To: david@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pbonzini@redhat.com, seanjc@google.com, syzkaller-bugs@googlegroups.com, 
	tabba@google.com, xiaoyao.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file virt/kvm/guest_memfd.c
Hunk #1 FAILED at 708.
Hunk #2 succeeded at 648 with fuzz 2 (offset -84 lines).
1 out of 2 hunks FAILED



Tested on:

commit:         2e590d67 Merge tag 'devicetree-fixes-for-6.18-2' of gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=67b63a24f3c26fca
dashboard link: https://syzkaller.appspot.com/bug?extid=2479e53d0db9b32ae2aa
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15343b04580000


