Return-Path: <linux-kernel+bounces-829619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA21B97795
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E0F2E818B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A691F27F011;
	Tue, 23 Sep 2025 20:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCtszWtQ"
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B23BE49
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758658710; cv=none; b=G/Wsi+RCjJx7734TDSNKKYZDnJ4Xqejed6hkTEHmQSgQtOD6fQJz875xmxLEtaX14Iv2jwlzUNdf7D8sSwCU1FkaH/9yOt6q0SFz+LAs/V22+faSXlKv98MjgH1mWwlVFMJVFv5hb+JNIMXIBSXZajIT81wbwQ7E0TIWjmNF+PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758658710; c=relaxed/simple;
	bh=OzA0m3dkIkJmA+BOT2+7JJ4lfxn50ByBk5+5Fb9h9j0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ZLN9GD48U2IUAaUVOETCINo0uCg6hTxT2R62WB8proqPDKeC7j9zvlYzRsU50CTtH/5+5XItnPE4ClESii18EnzmGhkXOM8IF3MLyeTnRsS+SfJLdNvHYcxNCECdO2wGL+ZcppokXFGCWqyfyABCmDGjdmVwjy6BuWfeELxrWIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCtszWtQ; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so7791601a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758658706; x=1759263506; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OzA0m3dkIkJmA+BOT2+7JJ4lfxn50ByBk5+5Fb9h9j0=;
        b=PCtszWtQIpR0PNUnJddttAaisb0KGgz7HNbVcbysVLewFSgzNfJ5cIt4oTsgiS0oK/
         k95gIyqjS28G3fpqMlT4Gm6prWq4yRmx1txQhmmO7tOnJRwlFtXixOM1bjv1e1zmChyq
         p7LxTKpb7DFYmnoB5PxCGxYaDV8EUK8Stfnbl2sWx/hRid9Rxg81lg7RMSgoMRd6YeOE
         9W+PvYXDap1uqNrWQODQcgxQ+jCsVLjEKRudo1oZbCwNjZZo4q0P79420kUbJOeCSz8J
         AKEFHWLnHU9nmjyAz0hDa/Fi3TA4KaGBjwRf8sFxDi/vhzGolbaiHPzBoJ8l1vVqRgwR
         qzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758658706; x=1759263506;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OzA0m3dkIkJmA+BOT2+7JJ4lfxn50ByBk5+5Fb9h9j0=;
        b=B6zoAjUqUQ4fIyWWJmeK6URoGc4vDgrNr3uqtXLKLDqf+1qP9upHw3vMGNnmVHUzX2
         CrLRyMna6IobD5bfUee1ealtn6O4zJNNZpK0TsiIZi69+ymjxv5seESvPp3yhYyyvhmO
         noZ6ITDQRZIXG14VQ61CBX9icp40uNOkmN9irhjkRgVdm1HyQJ+WmcIPdYbUTqf2y9Xu
         Ebg/iajQvLvUyKsgP9zRMfWYmh0SpSRhB4kHphmHrDnpz4j0zvOFU1kazf5/1OOc+/oE
         rOgir0+hiImzufQ1o0ZhFbUprvnriEUdMgNBjHnyVKGpPP0cRBWtMxaaskFb8idzRS/a
         ZWFQ==
X-Gm-Message-State: AOJu0YztRbMZuIQpoCqh39zsUXGvkt4CRtwXCi5eAkk0PiQRYWehqMBe
	fiMfoIucQxT3b51NH91yJhKfDLvIxxboWBRuFYhxdFpB2ZUhOuXIojSWRmNIJPUmw8qS4DuzaSI
	htU3cCtJPA+yUm7xc7LwL5KuxkSvxMDiENdz8ZzJCuw==
X-Gm-Gg: ASbGncvzS8lW2Yf0/mtwrf9htF5HTzoDSFj03LpS/0Lcz5k/TbCzFYAoH4aMWbiRjCx
	jzVNlcs1xhz+pn4Eba5iAYve1Bbc0l9STRM8ur4e3nBDC4ljLL6VvP+YL/MJJO/jRXbM7oDYsZm
	V2vCKM0vHGHCPCPRwUSj0JyEh2dBsQcYyLHkkJKl2p1yv3PbA4tuty9sTPM9xTHrwdKHbTo/iDB
	QTKfeA6gZmqDBn5D8cdoUp+MHxqKs7cWRWYR6WgqYNfALDj/dRy
X-Google-Smtp-Source: AGHT+IFCdJM1d+HYE4OeorJgb9cMDQXKrIKH++h+M5gfUVtmHBO8NR3rAjmKYTk/zUD9YFSLiX92hmOByy/3aXZ3JzM=
X-Received: by 2002:a05:6402:438d:b0:631:d76b:4c7 with SMTP id
 4fb4d7f45d1cf-63467678ca7mr3278948a12.4.1758658706493; Tue, 23 Sep 2025
 13:18:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "???" <domforeves@gmail.com>
Date: Tue, 23 Sep 2025 13:18:14 -0700
X-Gm-Features: AS18NWAmsH0ekS7cgk6gK5j24tihWsTvH53gGGMIiGkMxB1pt_5-RJG8VebaL2U
Message-ID: <CABKptHWYBQZ07KVWHDB_phBfsJkbOtJ3ix2QnBZ+amQVTm+V1g@mail.gmail.com>
Subject: Pls read
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello, I'm a 10 yr old fascinated with linux. I've been running Ubuntu
on one of my computers ever since I've seen linux. It's been my go to
for programming. I love how everything works. I also think it's really
neat and tidy when it comes to the kernel. I've been working on my own
distro and hope to release it soon.

P.S your biggest fan

