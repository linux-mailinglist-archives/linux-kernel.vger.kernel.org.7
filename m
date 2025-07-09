Return-Path: <linux-kernel+bounces-724014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1A9AFED8D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E8664118A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922FC21B182;
	Wed,  9 Jul 2025 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="HEZo1gG8"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E38228D8EF
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074349; cv=none; b=LnecVpX/UXy/cpLXDmqz9sRvYk2Ng7alIMHzhVBnkAn94H+BxtmAArLvrm+5pbNz9jMaiUXA/YLPG9QyhvYU+CHATUdJbK4fdzc+N+95PGlzPB+6KDkeTZfCzWDg8FdXc9JvC22AaFfrp5KxkgnfEiPWfRfrFesFBYk2c+du0EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074349; c=relaxed/simple;
	bh=X5LJhb7cB9VkHKz2ze5+Er4SJr+NBEPqnJ6oPBKECJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJAxzr0Y5I6XW5D5kT3kqRkZcSAKyG+39N1vriVMR7m2VT2q0REaZkCg5XJxxzKSX+/PN7NANadviEaiX+UA3dhiEfMEWyvwR5y+Cdr+5HAJkXiSxRBPthEvA053c31PibMJk4Wd1iIdlC37X+sF5SefjkC3TOPDaOBxzlCR1wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=HEZo1gG8; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6fae04a3795so104256d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 08:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1752074346; x=1752679146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zwmh6dMkrLy10LfOikgDpv/tXQJPIhFSOjGbT8uZzbg=;
        b=HEZo1gG8d89pLgd3oXL6jZTI3BMPf+hF7w7OgLfPnrUlfaG8AzAwgcpZEwDNbM+tFF
         vLcCaqYcci+E2t0X5v0HmabpeukJfuytZsC4YuySkrEATSQDpAZpXvfwVUFksv0TFiLr
         YAHNWXe5K1JR65hUIULXxgierdlSCVV8nY9SSoLi0+dzBlcvE5eXbhT/tplHrnTFG/i5
         NR2DQlNVUDL7EW/XAaeF6oM9dKmdzPfcabvtOZj9JeDGgP7I74rc8VvtK1Hk+Rqy83gY
         Dbbkh2e4awBxpoKKhlrgtsDjEXt6vAz3BSfYaC3wje8OpZLG5PwOj+B+ffYMJBmV86uJ
         uPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752074346; x=1752679146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwmh6dMkrLy10LfOikgDpv/tXQJPIhFSOjGbT8uZzbg=;
        b=VIdRuCNICeUrGB+WwzGzst4pcGNBIfj974fJie7RBPWrEx6wPm9jMpijTDrZ52s1VR
         AeZz7w2IAT56O6l0ZtsqcCTyJgHmbC2fntfoFLf9zgxro2avLYXcnPZpuMTxq+/Q4Le3
         DuS4UAR6Zn54ZfbLiQ8gp4Ch1jEsymYfSjvOsGNrRtRgGAxi+Rmp96x+taEJiz/tcNe2
         R4sBFP8bI6u7slfgSgbu3cKEBd/1llFjGKR2KbcSlGAg+ZgodnrZNITf/NP827UNKaVX
         M4Kz2AJM03cCPNhURBINF/FUAFdoSK1gD1PIuyU1oIIplj3L0btGZN3V1cMHHZx0y6Oi
         E54A==
X-Forwarded-Encrypted: i=1; AJvYcCUV4/vSPXs/VZC3kkpZXPXy6toP21GmCdD1m5KmQUeVHQjIBybEiTZI2jJsDfwVEpVcXWoM4aln0HSHmsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEo/5OsikU1awkbyfJkh3Rh3IqaedyDGowA17uENFXS2DU26Vn
	l/4yXlM8OyzykkDUCJjpTfIELVs1teURFQtf0BGhy6iqVjJY/01s1JCufNJFgzfBuQ==
X-Gm-Gg: ASbGncv37kAMP5bV9BCnOzWbPH5cx0GU7eZZhV2eAaqHDtP+L6a90eMhXh5EML6apOz
	HtNQ+rbz86w4XRglepD1/Tcrmdr5QxplIaD1DtTLT0aecWUa0/Gbrmk7E7yFsc1fTEU0YRL5cg6
	2ZzK6xBfeza13N04nhdyTM8daCTNLsARBJIzc3a5dgvY1mojf2j1WqlFZy+f3VlCN0/TadeQKdM
	rmUQPoEt8f+91QXrbDBsZhIkRiEozU2y01qb5sfVHmSBy0+2txRnb8hcQYjlBlS3Og3cEdhgDJu
	ulwCTh6dbwVUlVXX8yoFtGcK1cnei2pe4bnVIboIHHW4vVtglzI+NQ9MDKCMlRlqJZfP6/0a7uO
	TkCBo
X-Google-Smtp-Source: AGHT+IGOCWiMIbfkpKNw1O9iitmq0tJWHj6/x5nDWd+Kp/5Y9Sj25o/XLA4/PDGaderMKoxwdVxE3A==
X-Received: by 2002:a05:6214:1d2b:b0:6fd:26bd:3fe9 with SMTP id 6a1803df08f44-7048ba5ec40mr59267406d6.36.1752074346300;
        Wed, 09 Jul 2025 08:19:06 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4ccd715sm93341856d6.47.2025.07.09.08.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 08:19:05 -0700 (PDT)
Date: Wed, 9 Jul 2025 11:19:03 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: syzbot <syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	USB list <linux-usb@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [syzbot] [kernel?] INFO: task hung in uevent_show (2)
Message-ID: <dd932df4-2a13-4a5c-a531-376065f87391@rowland.harvard.edu>
References: <686e7698.050a0220.c28f5.0006.GAE@google.com>
 <79f634db-c149-4220-b8d4-0fff2c6b6a01@I-love.SAKURA.ne.jp>
 <e064a3e4-ae70-4a24-ba5e-1bb8c7971f23@rowland.harvard.edu>
 <39f312fa-d461-4377-b809-50c8a7188f6b@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39f312fa-d461-4377-b809-50c8a7188f6b@I-love.SAKURA.ne.jp>

On Wed, Jul 09, 2025 at 11:44:46PM +0900, Tetsuo Handa wrote:
> On 2025/07/09 23:27, Alan Stern wrote:
> > Which of these three BUG_ON's did you hit, and where did you hit it?
> 
> kernel BUG at ./include/linux/usb.h:1990!
> 
> matches the BUG_ON(endpoint > 0xF) line. The location is shown below.
> 
> Call Trace:
>  <TASK>
>  hub_configure drivers/usb/core/hub.c:1717 [inline]
>  hub_probe+0x2300/0x3840 drivers/usb/core/hub.c:2005

Those line numbers are completely different from the code I have.  For 
example, line 2005 in hub.c is part of the hub_ioctl() function, not 
hub_probe().

Exactly what version of the kernel source are you using for your test?

Alan Stern

