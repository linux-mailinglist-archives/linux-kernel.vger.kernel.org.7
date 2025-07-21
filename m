Return-Path: <linux-kernel+bounces-738634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FB5B0BB49
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 05:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C671759D1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 03:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E2D1DB34C;
	Mon, 21 Jul 2025 03:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IL6shCeH"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E5C46BF
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 03:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753067770; cv=none; b=Wc8mBdUGYval+FqYp0E/m1AlujnEaq7oSzLICjx3UxzW6WhrW0UcLO4b5tAEU9MP99JNUoEGuYf8p3oJifs4GKt5U9MZNaPOQfq13+Y+2DmElTcI6u/JviRrHU7ueirYcpzJ7G/sANANX0cn8nZxHXELAGqIOSX2Zm6LzYnx9Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753067770; c=relaxed/simple;
	bh=rSWv4zFTb3j8yRwlcqRSKbpvUIhdonFOb2X4SLSxZX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aA7PypZQGvgByAx1eCjGtYUp0ddpATLQZwFXMR/pMuMrtvTPymgc6zSEkx0Jv0m3blvXoPaN7h9ycbj/Fcp+KiqmQB3Kp5E/wbMxv3q3nYRIqA4Rher+65k2ZrZTvK47iWROvXY/yPh6MaqYdpw2Uplnf7VKurSHoxlKOlFSUZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IL6shCeH; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-235ef62066eso45257715ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 20:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753067767; x=1753672567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tEHkdm832hTynzS/xLG26Wf+TEMODMOzVO5dM74VcWw=;
        b=IL6shCeHXNOsBpeqbbluC5+N5doybmEtbV4/8YrqamyfGnA30RBwcT0QlsKzM/4n/4
         5gc+8IC72JNJC+UXKMdmg+NY71d6hknL2yLRrZQmQist4G4RhQIkfswk3vygkIlgTbwL
         4TlNj4ZOSHjausxv+Wm/hEgJ/X3wAQmifd6XU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753067767; x=1753672567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEHkdm832hTynzS/xLG26Wf+TEMODMOzVO5dM74VcWw=;
        b=GPtQQpkRkJzfCy15YGfxG4bOTklFEn8WEfGe+vZsbXFzq9KzMXddeKKG7p7mTM8WyH
         jNDm0WkyKpQSh1E82CiUlAP88XxlErNPMFFJMZw6z3f+fxvkymdGBwhYF95wXklsas43
         8TcNO14LZHQcfzDaiSmVF78bIAuwWE2SyBXq2eJgcJmE2OJls4/fqE2H3W/dZEvGutvR
         4k6ei6wD9hk/qsLqiDPaYGqxksqpno8zJsoHO6MCa4hi8we1FsoEIPwHOGF3OxsQNQ/r
         hi/6LDY4iWTeYOwBivLtdNDp57mS+gaouAuLqnbhUkAKJgpKM9zoU4SCHCotciKHc89q
         4W0g==
X-Forwarded-Encrypted: i=1; AJvYcCWBCznwff8seSvnL9M1pCvJxGkFPMQiiX0n9FCgHX9jrZkcPQAUuUoCalx8il3AuO4fRMQ+ZEM8PDdek9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywke3OpP+LhFuVjeAI50wEd+aqZG8oe0ACXc6a+aRxVwqzv8ewf
	Nw8FhMFjunVDPNsgT+yCbSvxgymIBHUx1VW+Mx+IS6AoKZGztkjS6Z8vaXnsIu7ipA==
X-Gm-Gg: ASbGncsaPFRW829R+k82GId1n7NFojdVIKGE4L6zBctxQUnrDFisasf7pJcjL31fk03
	gttp5CTwnmLmz8D5lQeVA+TnuJKDcYuXPIzL8cRKB9/My20Pmr3CjmbQu2CzgoZdzKJrI9Zu+0l
	1c49PlHy88N7taIiRxyieDv94pO5GMhJEIQmKhgZGR20xmuOzt5JB/TLizbHBZlxkNPV54Cg9F+
	hsKOnLT5BE9Cgu7iiU+E4Itx/VAS4HpTHjO8os9W1G6KqAXgQaEx1677a/i2y1atbR++u6R18QM
	OxrIDW6/cfFcADR5jsszQ3+hgkt+ueKXmNoLGesCq5Je2firW2bFGxfDJ2vWMvQ024M4ie6n0no
	AZ0YtknwWgAFJqpwGEKqxmfShoA==
X-Google-Smtp-Source: AGHT+IHBqV5AH7e/4eflt9c3XJvhjaEBjyadSkqKL/UtcHHt794JhemiQyNSy8Uct295fuP8sS1m9w==
X-Received: by 2002:a17:902:d584:b0:234:f1ac:c036 with SMTP id d9443c01a7336-23e3038155bmr199322855ad.50.1753067766876;
        Sun, 20 Jul 2025 20:16:06 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:ca29:2ade:bb46:a1fb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b55ebsm48127505ad.103.2025.07.20.20.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 20:16:06 -0700 (PDT)
Date: Mon, 21 Jul 2025 12:16:01 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Askar Safin <safinaskar@zohomail.com>
Cc: senozhatsky@chromium.org, bsegall@google.com, dietmar.eggemann@arm.com, 
	juri.lelli@redhat.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, 
	tfiga@chromium.org, vincent.guittot@linaro.org
Subject: Re: [PATCHv2 1/2] sched/wait: Add wait_event_state_exclusive()
Message-ID: <ofvya3en67l6gxw7sxzl6qsga2x46mdsusrx5az57kw7eihwoz@m5jyjhdsssit>
References: <20250610045321.4030262-1-senozhatsky@chromium.org>
 <20250720205839.2919-1-safinaskar@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720205839.2919-1-safinaskar@zohomail.com>

On (25/07/20 23:58), Askar Safin wrote:
> I booted into it.
> 
> I mounted sshfs filesystem (it is FUSE).
> 
> I disabled network.
> 
> I did "ls". "ls" hanged, because network is down.
> 
> Then I did suspend, and suspend didn't work.

The patch is for background requests, e.g. for those that
are issued on a not fully initialized fuse connection.

You probably tested one the wait_event-s in request_wait_answer()
instead (as a guess.)

