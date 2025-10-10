Return-Path: <linux-kernel+bounces-848244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD90BCD008
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43804188E323
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934DC1F1538;
	Fri, 10 Oct 2025 13:01:17 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58D253A7
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760101277; cv=none; b=t4PYM/+UtBaqMS5+ERbGW0KWYkC3X5cW342eLBADMAkBHsIid9w3+9wvI0EAR3GZZ4+z+zzU8zCDVJSQJv/cV2ZarkcoFoZlJLgLAjBq0+cDsLndwOXxo+Ze1c0uwBq9R4hFho9m+nxp+tSq/4nA4YQ5q7wBvR4+I0UT31/HkVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760101277; c=relaxed/simple;
	bh=fd5ao9bKL9xp0E8r/3pofEHL5ccsTpXi69s251qi51k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KqlfDV5rkwKONWdH5OD1+2knn/kKIRXFVAzpy3goZjju1zs6yWKu67XD2wV2xcreWaReUjCLHoPYDgpqJca0HNimXnXJvZLAMgs38gbl11dZdoWqpECeeP+GoLDGokaGe3ocOjjIoeE+yYtTEMWzmq2wBYCRwgdJn7ZJr/k8d2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-90e469a7f6bso599951139f.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 06:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760101275; x=1760706075;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fd5ao9bKL9xp0E8r/3pofEHL5ccsTpXi69s251qi51k=;
        b=a40/pnSOtte/HNXjl2sYXl8C0fMncvTJ8H6V3Ls8y0m8Wq8Kya0tFWfLyMh0MlGIZC
         zIWbn9HVq99HTLZGBThO4Y2AZGzCZ0oOj4uvEnLCo3+6Y3+gZy+6unsTSGzd4+BNr8iF
         cEMcZ4RPpoz/5XV4y1KGAfWxzvrxvrVPRMplj6e3XQpHecgMTPWTun4i/TNGmsxtovbY
         It2mbwoAkrjJ07f5orQaJn4xdDrOnEMRIwh6JHyq+wylTme+J74EjRX0BoSiEBFUF2OC
         Z/8YiTOvG2/faqGEfOGO5Yeu5URGTkcJv+TmfSy4aKmpaoDNn5qHI/WfimnAc6MSvx5S
         0l/A==
X-Gm-Message-State: AOJu0Yzj0K/8lAWM/tX+KJyBQa5gTSayDBOAuXw1JCvs08vOyRztp2mR
	WblmpsuKQ4usI2QkEJGaoxZuR5/hMDH9zgkol8ZQPO/6kCfaRp2796aHpooJaxT8MSiOCFI8s6k
	oeY33Nk010T7XsgMVVQ2ise6qzr/Q50u/Eyt1r40WRzpoktPPC4dYePouoUs=
X-Google-Smtp-Source: AGHT+IFCuGzvBV16gwYWWhifnl3LT+790DBgQI5Q/elPiy6QhrCcwmqb006j2WAVg5PfNKNVGGQQ8fgm8ENdHqoM2ympcAons/iH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13c9:b0:887:54d4:a8c8 with SMTP id
 ca18e2360f4ac-93bd1987b63mr1301266339f.12.1760101274711; Fri, 10 Oct 2025
 06:01:14 -0700 (PDT)
Date: Fri, 10 Oct 2025 06:01:14 -0700
In-Reply-To: <0000000000000fe556061725a7be@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e9039a.050a0220.3897dc.017c.GAE@google.com>
Subject: Forwarded: FYI
From: syzbot <syzbot+aeb14e2539ffb6d21130@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: FYI
Author: nogikh@google.com

#syz invalid

The bug is now a mix of old and new reports. We should adjust the report
parsing so these have separate titles, but that's a separate problem.

https://syzkaller.appspot.com/bug?extid=aeb14e2539ffb6d21130
Invalidating it so that it's reported again with the latest stack traces.

