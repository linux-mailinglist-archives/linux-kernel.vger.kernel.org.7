Return-Path: <linux-kernel+bounces-730110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D8DB04056
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DFEB3AA5C2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026FF24A066;
	Mon, 14 Jul 2025 13:40:39 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334674315F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752500438; cv=none; b=hMNICI00h/tHx7KB+FvlTZPZbyn5XFr/0ioo2kLmQWu09CuDDX8GRKFhD7WVzPjCtovDcjy+T3IVAOB3c6hfkcz4G0Eyz5qPrIsLVOfdp5Kwfud2MB3Nq0446Y0UhMCt6FMLmhKfTCOkKlpOc2fSVbmnISOFHlxOe7AylVAyrL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752500438; c=relaxed/simple;
	bh=4GWu1k9pmyQRn1OaeT4oB6EBBy1R5WRANYKE009UWTU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q/FIApkG+STGSHo8jyczaK2HgYj8x7aEVm8qInpXy6vTk4taegvn8o5dtxDeIc1d4waU6Me/2CQ8dG1o+JMN4AT1cEecJvRtSpk1lQMlQ7YCd/GEHklyk7P6fE5Fy4mte5bfLcr50FTGlWcSHEY51nAXK4d+uwNDvKX8XrqeZkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86cc7cdb86fso463885439f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752500434; x=1753105234;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4GWu1k9pmyQRn1OaeT4oB6EBBy1R5WRANYKE009UWTU=;
        b=tYJL7gsPn2RQ0BzfjnfdjZ6Jj19jVYYNZiciaMe0qZdyh9TjXjXs1N1tjKSqb1nl49
         IDqaDfGnFuVWnfb31rV9fWb51wgoxk1THsLhKktqvYsNz1eB4sZsbjNnyYfUbzaLOqd+
         k+ZZVIE/UphnYrtmLOFilWY85sD4189AsLm9WeLJA2qYmYykBflLb7bXeAfGpK28XS7I
         64IUZGQU/3xXLTJhzJVNhSw0tLJVtUV8hQyxyCTbFQRjrHctdeoJOEDnXG/0/kBmU18n
         bSapuh7ruz4y/++1Gb4Ccn/zdxq4dZXenqgTgTEhix4bED9y/w3PfazOfybr+JoZlOtJ
         YGKA==
X-Gm-Message-State: AOJu0YwHyADE4MYR5HicGmXKp1E2r/yulA9wptqT5WqbyOjLRqn1lKWx
	3a6sBFyYLCcSWj/tzkHt1H45+vNkArazZb/rQjU6W6lm8NNXTwle73ZF0Dv+FVDc/+drzuulnbI
	jMVwvvpEa4PpZZ/6NIi/3CDBLdEn31ZCR0scCuZb6o6whAnQkiCFeHmVRmBc=
X-Google-Smtp-Source: AGHT+IGtfmIpR/qJJdETKejOR8OoS0dz9g5e4bvZes7GsiIZ/c7HwR+X9NQujEPEZrga6FisP6qxWr2STg0kfCt2FkfolRqxdGl4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4804:b0:873:1cc0:ae59 with SMTP id
 ca18e2360f4ac-879787fc64emr1311702039f.5.1752500434263; Mon, 14 Jul 2025
 06:40:34 -0700 (PDT)
Date: Mon, 14 Jul 2025 06:40:34 -0700
In-Reply-To: <000000000000997dac0606e7a57c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687508d2.050a0220.2efa37.0017.GAE@google.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in __kmap_local_page_prot
From: syzbot <syzbot+b18872ea9631b5dcef3b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: BUG: unable to handle kernel NULL pointer dereference in __kmap_local_page_prot
Author: pranav.tyagi03@gmail.com

#syz test

