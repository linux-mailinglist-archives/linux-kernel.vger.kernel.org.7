Return-Path: <linux-kernel+bounces-741699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84836B0E7FF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 03:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859093A6871
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 01:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECDA3596D;
	Wed, 23 Jul 2025 01:18:59 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C967E1853
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 01:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753233539; cv=none; b=j+agPqBeprkVftSTlb4+xaH9LX7AXihocioi3IQ7TSa2NlFQhADdaLd5SfDcjxWPoQFhAr2FOx9d1P+1ZWFkMhaIynOyr5JOhh8X2c6DtT//VQ9Rco1HpIE+4R9KKta1VwcMkvEQTRLo0rmG+LpBVhP5ceVD1uE4fUnrugxfHNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753233539; c=relaxed/simple;
	bh=9OlrydaUpg3OwHFmFhJUEKn5dj8ZSZkg1QuWWVFtY0w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bo4tfGwvDKiQbgsuookU4fn0+KpMwAdCFd+eX2Q0SoerDkAHfG1S4MK1poA8h92QoPfCQrcQXba3g8ZxMYZm/FH9+hgtLyYgsXEKeeVnT98Pb2vz6N5RNalVGY8XbW+h2uTtDy548nShp+Ok9KnxRXB5UHzmhMQUI9nft/DWcO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-87c2bcfd156so61082039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 18:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753233537; x=1753838337;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aep9h97yzq8BxK3rUKzUgGRp8xlimpOzQ2+X26fDUzI=;
        b=l8wNF1v1EVusPmMeREjwSAdYc2O0JLfPm77rp1aq4T1XXVM8z29vfZTGlDai65EExW
         3uBAUl1UAq6U1oKpUQOF9tvop+mh26piJcGBYlk+G697VWbJqGLfsF61HV+SEm7UlGpx
         Qv//HG81w5h8RJLd31FA/E59Y25aGdpOpwIqeoCiVY1magvD0LAy+DRYiLjfGmJR+VRu
         qC7Xs/61YLUcYSC4HH8AXO0MYJbplH1PRy5mPN+RFP+F2385ZVCV+Jj3HvwUyrZyffd8
         Ktv8044LCsyRCqGnAkVAID9igo2ztBJePlsq6dFa7anVl+ltchJGFPMdC+v30zUckgFd
         gNew==
X-Gm-Message-State: AOJu0Yys2vBfppvX9l2j60G7Rcy1gEhq0nn5o2whQRPIlMWiH/3Joy2K
	X6VGWKemzlCFfUXTMFw9OmNZMiv72WPlqWfa8t41eb8F/2mnHxoTAM7U4Zoeldyrk/FqtzNo8v/
	AqvsVytOZOxNdVFPV8a24KEssU6Izb4EX908ij87nVGMkvMpQVMOR2ka1Pv0=
X-Google-Smtp-Source: AGHT+IGtMYGKrdNOKpcHW9wx4mfLgFDlsqfl6v4px8mTkqQslvU2nRKY9riVNdo3mSfvuYpNTInnyCQmUe2IPX8C40B/10ifEquS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6013:b0:867:16f4:5254 with SMTP id
 ca18e2360f4ac-87c656759c7mr210401139f.6.1753233537153; Tue, 22 Jul 2025
 18:18:57 -0700 (PDT)
Date: Tue, 22 Jul 2025 18:18:57 -0700
In-Reply-To: <000000000000367c770617901bba@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68803881.a70a0220.693ce.010f.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+7bf808f7fe4a6549f36e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Increase BCH_MIN_NR_NBUCKETS

