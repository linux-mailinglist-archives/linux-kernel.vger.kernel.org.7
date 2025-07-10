Return-Path: <linux-kernel+bounces-726282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B29B00AF7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF3B8B40D49
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B79823506E;
	Thu, 10 Jul 2025 18:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jibJptDM"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9E72FC017
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 18:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752170519; cv=none; b=nXvvfEQmRMZFGpxjsXE3p9wt+JUibRkVO4PpZmRKrrZCv+mM2KvrOKkYZK8sYPlAg+7S9jMUpJCnZPG0+mNxNqPqjmtMYfi2Cb0/9hGRfx9DlmgIR4524X7/49BbpTykMRS9pKzK+xNz32sYq2g1cf8VxpnQSLEmqxZwFHiX5V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752170519; c=relaxed/simple;
	bh=L5IkKlOj3J4XNHtFh8P5zmvhaqsB1+fRpTkoOEh9Oew=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=C407QDStXcvfymByBX7eo0o95CX2DlY8iEIfTGR4uUl15aHL0yTijC2+XHJQkjfITEObIYswdypitRn8EFhkSnYu8lEMRQjy7S/glXMCvLjnL3UWlhr514KPCmb8D0fHH5JMGzxhmOb3RgpHU+9J4tqDC0JNI79ok/qwdDxIthY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jibJptDM; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3de18fde9cfso7462465ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752170516; x=1752775316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0gJmPHmpJWqH0mqoGuNdr93R3misLm5TaevNQ3bEZao=;
        b=jibJptDMA8H2NCFlSKGkYNv5YqKk6EFZchSOnCTpT0JCnVOi8dygzmajVASbFFdPBA
         uCPZB3Va+6aM73Kv4bvaBB8AZqDHSuwv+Tup9zKKVo8dYYfTEGF04+PZ9eEMVliLWVwI
         eHe5GaI0m5aBnz9z1wu69t43Fy/7zj2tcfi9lvRS6L2H1j50IY9H7R6bI3vO4gONGNKM
         kKJPoUinhOUwgXnTiypiq35UjhWjYZlFRSzY0d+RZ1iD25r1NH76HOwA1A9wUkfgDhZV
         m7YkYoe/rebuKgZmtaO1mILypwF+1u4Q7a3S6DvVQRNnAB3NZbORtm8GwnYsQ5BWNsJl
         VS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752170516; x=1752775316;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gJmPHmpJWqH0mqoGuNdr93R3misLm5TaevNQ3bEZao=;
        b=kGhDKlb+kMn73NvMIJ/nmD1GGxNcqx59NE6o9VhmY6u76p6OxSrO5adoRBXzoRF1p9
         O70PE3rtYxvWX9IHZDp92u4VR4w1nYFm+QMiFbfIrCJhLMgrWZN3lolubHEFD7CoqQU4
         Cu5UyC9/9ukfYOZNdiNEQNUmsNrrJj5HWcvNd7tO88X3C79nb3ieFv1Cru8zWXXz0gBI
         BGXFOppS/Gbahh0grJwYIZyR8X6ulSneflk9YSs7SppSNmJ0Sa1Eg7wIP8j2IoMeQmFI
         2QjVlppmhLVwwmAiP0Vv6MdW+P4dvY1EzK8ES67nARFX3VSNmLErYg6iYOLbFSxKhnJ6
         TVbw==
X-Forwarded-Encrypted: i=1; AJvYcCXq9ljG9E7YnsBKeZ4YMBmxqH0XDwupGNw3gBCOtWck1p4LOvTeALvA+jyX7VH260ut1keZFfZ+Xpq3yXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo4gfGnUmh65RUuXQyLc6MZOiT+yiDC3Or10sFGpIZKEZ+Zqlo
	CkZ1Ku3MyYMZKOgGQGQX/O7JtLhytCLFTKFsZSZDSUlQwQuEAnWz3lG2cNAsMg1vuvg=
X-Gm-Gg: ASbGncvcqyuX8Hqv8OE03HE4aCgTcD1j4WY8OPYMSICoZeuLQMzVRP6RBXqvvpggK0e
	jKYgM53kKAkqp3mUmUuyg2F0q3ZQBverc8OEjvapxp4UElsk4c3Jl4fo2U7cDF/SqWU1hT7qXLt
	Ob/TiQ6nYa3t352UQm2wrof/dWhi9cnr0Ex3XNUKjiA+T48k2IZMnsDcQJjqFG77I8x/giLBwU7
	YLNQscnWRudNgknRiIVqye1otBT1203Z8shiZpD1KZQLbTaJsc8/h1FCqyGoYTJ4x0BOs8ZFllv
	z2LC/1Y/H311bNZlsi7qLYEvSH6UX6QOpI9PB+kZVRNAb7A68mK+sWNr0PA=
X-Google-Smtp-Source: AGHT+IGoVnph16PY4CbMSMKUkPDzfgnKRaza6M6yhcl2rhW6kjzGYnA+ONxH4Ld7nu8Dhyjq47z5HQ==
X-Received: by 2002:a05:6e02:b4a:b0:3de:287b:c445 with SMTP id e9e14a558f8ab-3e25318ec6amr5108425ab.0.1752170515179;
        Thu, 10 Jul 2025 11:01:55 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e24611c645sm6406375ab.12.2025.07.10.11.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 11:01:54 -0700 (PDT)
Message-ID: <bf1b2aa4-9ce3-4ad5-b0d1-fa379b96c9a3@kernel.dk>
Date: Thu, 10 Jul 2025 12:01:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [syzbot] [io-uring?] INFO: task hung in vfs_coredump
To: syzbot <syzbot+c29db0c6705a06cb65f2@syzkaller.appspotmail.com>
Cc: anna-maria@linutronix.de, frederic@kernel.org, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 tglx@linutronix.de
References: <f368bd06-73b4-47bb-acf1-b8eba2cfe669@kernel.dk>
 <6866e5f3.050a0220.37fcff.0006.GAE@google.com>
Content-Language: en-US
In-Reply-To: <6866e5f3.050a0220.37fcff.0006.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Jens Axboe


