Return-Path: <linux-kernel+bounces-831318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FAEB9C576
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78CB57AD2FC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA34F288C0E;
	Wed, 24 Sep 2025 22:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlj1xJo9"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C5726E6F4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758752227; cv=none; b=Tw1eZ3yu9vO2iz/WDKgonXM4fsv55fgCcWjGO6+jkoZPNxndt2bZDKU2EldHZifQ0j2jd9Ru8Ss1qcBaQC13JvhTQynAXh0GACj3b/I2//nLgwYxck0WFjL0zk7328QPktlL13/3mU28eKu0PjwXmcQ5iz6Oq2YpVT1VR6A+nmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758752227; c=relaxed/simple;
	bh=BU+WCA+80wupmR3ABcOoM9JcjfSnFaN5GnaRcYFKGKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+Ef2gmn9yRCvkNSHCKlWh6w0m2kU8NeQfyzGqq1JTKdyWfP6jGeXAdHCk2NSJ0Nm1zqQGcHE463MNzozyGuY4nAHpTl7Rd8uqaCSHgMpLx1vj+9GSuyzGCKAUqh2szs0iyIuCQSnLVSLgIx6z3NOPBG2CR1LapJhdGHAxgrNvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlj1xJo9; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2570bf605b1so3859665ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758752225; x=1759357025; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BU+WCA+80wupmR3ABcOoM9JcjfSnFaN5GnaRcYFKGKI=;
        b=dlj1xJo9wynkw217fSt+MNFgZyZXR3BPYiDGYYwdybK91yaKy/DZRomuMhFt8zNml3
         F43Iy9UZcXPt5XgNxaZRc8uCEL5MSTFpC0yRXgAAUxylblXGRDVbon5PzuLuMZDu8ke9
         JTHq3ZkAqvHEyCqhLTQHiQ1e8kSw+qQ3C1OVRi1bpBbQxmslnxju+HOzXB0SFz3zO5pN
         oVB/sz3157ygjPfPI0RduGIWAnV22K45GUr3owTVK9GpmvsXJTVJnMwgQo27xrKUFyaN
         T0sT8pEJvGSdDvu0Vgd7FzFWDLtCJw3yOteBrNBw8V+CxmZiPVDBYK62sVOj+ryhdRHF
         kODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758752225; x=1759357025;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BU+WCA+80wupmR3ABcOoM9JcjfSnFaN5GnaRcYFKGKI=;
        b=NqKnIZ2OuyyKgNyAS3gUrvfTuo0h7iQv+7wL5nxYfbrW2OYrwYdjvEHu6C1QgXhVx9
         AwHmPya6oh1+bx/Kry0nmN5GpOlazdrAl67rsc/aj+i4A7dzmX8gZc71A0eofrmiV+Lm
         XtUQpjvLj3e+d7b/PYgo1Iv2Q08uJL3hmWo2FC/8ldN9w/ueJAHad+nTXg+Jkpau4/MN
         j2riN84NfjfavZnqSnhqq1Ia2yEZkakYfHwhA26sWtOOFJnRdRkGw1JfGDlRRJNVMFW8
         Uu75O6qSukuMxJY63/gyQlX/FjKf2D8eSWbhsD6LSKiuDsR7UDgL9D0s8JI/ojT1iohW
         FOPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLk+T3rCpxSSBfxCIh1qxpNzZ30h9uHGLTGNYo/2KRaERMRmv5tt91PK8PZVO+a/S+LhSVWAY2vj8uumU=@vger.kernel.org
X-Gm-Message-State: AOJu0YysVbvxOvP594YcLxqp7yoyAyC9t2KLVL2F2JtQ/DPJTeGjd1sF
	aW0y3dycu/pp12z/IuitaQn1BGMLCRSRdAesNdd7OTB1OBAotsuUem5qfoGCnDzvoUmIesGMCic
	xQ6TXfZdArRsBZLdALQfXUaO2DqYE1mQ=
X-Gm-Gg: ASbGncudDJjQ4D7JXOmg99Sj18wMc/ORUDHrZ1h8TQ3ewEIK3ZHm/lMJof58bjSfLUQ
	PWvfqeqGinHJJ5Mi6A5UuxWWTstS6HB0MQMujX+euw9f8qaaf+z5f+EGLv079vn1yii8pOe1grL
	Q4cM6WQ8rAV3kA4be8CyRyFScP4qBvAdMa5/3jlNKZDe6bViWuQXH+d78ovyzP8nxBk0MWJQGak
	dbv
X-Google-Smtp-Source: AGHT+IGLga4Nd275V5VJ+me2n4+cweQRd5SaJpr3IPBvldnFR3TBBvkIVeIyqT7wP6rW+eYpEw7ocZ4oYldyXDIWVeY=
X-Received: by 2002:a17:903:2442:b0:250:999f:31c6 with SMTP id
 d9443c01a7336-27ed4a3165amr11107805ad.32.1758752225112; Wed, 24 Sep 2025
 15:17:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918201109.24620-2-julian.lagattuta@gmail.com> <000808f3-10cf-46ad-94f9-95a142c08b59@suse.com>
In-Reply-To: <000808f3-10cf-46ad-94f9-95a142c08b59@suse.com>
From: Julian LaGattuta <julian.lagattuta@gmail.com>
Date: Wed, 24 Sep 2025 18:16:54 -0400
X-Gm-Features: AS18NWDEw812FHiWYzAMJ81ep3O0jjDYxHiHcGHIsuEI15DM2GSEPmumxHFcyYs
Message-ID: <CADuX1qJZ1V32d0U4hSOUOzte2KE-k-Hzop0zZd4=7Ap-kS3JzQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] module: enable force unloading of modules that have
 crashed during init
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Could you please explain the motivation for doing this in more detail?
>
> I think we shouldn't attempt to do anything clever with modules that
> crashed during initialization. Such a module can already leave the
> system in an unstable state and trying to recover can cause even more
> problems. For instance, I don't see how it is safe to call the module's
> exit function.
>
> --
> Thanks,
> Petr

Thank you for your response Petr. The motivation comes from when I
wanted to replace a crashed module with one which does not crash
without having to reboot. I looked around and saw some other people
complain about it on stackoverflow.

I thought that if a module crashed during init, it would be in a no
better position compared to if it were forcefully removed.
Therefore, there is no reason why this shouldn't be an option as it
couldn't make the problem worse.

I agree that calling the exit function doesn't make sense and so I
could change the behavior.

That being said, I understand why someone would be wary of this type
of change; this is just my thought process.

Sincerely,
Julian

