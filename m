Return-Path: <linux-kernel+bounces-842243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 280A8BB94F1
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 10:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCF5C4E2CF4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 08:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6484F221299;
	Sun,  5 Oct 2025 08:53:47 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914A4C141
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 08:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759654427; cv=none; b=JIOy6NvCbqvgUqOZHi0TCrMLACx+1gAeaxYg6I54NRgGquXhR+sULdLq6GxgHJskkRTLe/joW/0DyQxUx+whn5lRjud33rP6BQELic4+OJibBxeoAh4AU74BkvNGydCkizSWUmtJo3tPF8vxl3FIQYs4XkmXlWOEsn8A0FDNtQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759654427; c=relaxed/simple;
	bh=7QKvrEDFQ4uange3//hcr6eQ++HI0Iu0CmAJTLo1hHM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=I2m4ZvciGZiqOxp2V3LMubSuQBT6zrxajxjnIMPk8RVGHOGS+72PWQf+dpZkCkIuaUrQDT4TTzeHIkummPmvOLvyAyMDAyMZ+eSDvG7y8l+0aSjFCVMWGfZK8TKB8poANbiI3e7Bm/xNXEjS9zQXWsC9Hg7spzXoJfTx1Iu3O9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-919d48f1869so913330739f.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 01:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759654424; x=1760259224;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7QKvrEDFQ4uange3//hcr6eQ++HI0Iu0CmAJTLo1hHM=;
        b=tl1ekKCV8+c/u8Mduf9spMwTI/Cjl9vjSwag1fowdsKst4qfxhiQ2x2l7+1FmsQSj4
         XXEQOaqL62fuOAnVECT2jzQIKfCZfANPHLQqyym4BB4mlinZAvX2X59yTpkN7txD8biT
         g6gxp2lkEuo0+NZYId8PeLdueAd34m/+Wz8VE4UpR93fYhwNf90Z6xSxqFDapQARPPuG
         XrF9vv3T96lawWRv4Mshnkj4dvY0FGoBdTDYc91okOkppCJ1iTYd2Fa4ljwkJ7m+KtPB
         4DMOkwqHtrwZPf7p6OEyqeuSM1/FShrbvezJG+cqD/9I2wEA65y+p8KJFC38im7CHBnL
         ibww==
X-Gm-Message-State: AOJu0YzsKszt2M++NTMeijHaozpVr3dk2gF/AVF1PPQfAs2gQPEDDOEs
	dzika45MiUM0WtaL1pO+ekaPLQawkG9031iTQxILN04KnVlj+l3SAIPL1y3V1A8EXR3OJwMRYNu
	CS5g/huj5ByScs1kO8dzRzZs5XXiLwZff4APIF0fRSj6iJTaDeK+qZBlmtxQ=
X-Google-Smtp-Source: AGHT+IHU1NQDsarooiZbpmjSvXbYYMGKM9jgenR7uLm3ILZmT9YY0OmiqrfYdWn4LYFCOn8IsFdWslwmwbpOKzaQswkRbwex+uTo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6209:b0:928:6b27:1d75 with SMTP id
 ca18e2360f4ac-93b96ae9720mr1161861939f.19.1759654424786; Sun, 05 Oct 2025
 01:53:44 -0700 (PDT)
Date: Sun, 05 Oct 2025 01:53:44 -0700
In-Reply-To: <68bf2c3f.050a0220.192772.0884.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e23218.a00a0220.102ee.012a.GAE@google.com>
Subject: Forwarded: Re: KASAN: vmalloc-out-of-bounds Write in imageblit (5)
From: syzbot <syzbot+48b0652a95834717f190@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: KASAN: vmalloc-out-of-bounds Write in imageblit (5)
Author: albinbabuvarghese20@gmail.com

#syz test

