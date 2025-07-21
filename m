Return-Path: <linux-kernel+bounces-738534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31D1B0B9C0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 03:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE49C3A1F16
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 01:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602DD17AE11;
	Mon, 21 Jul 2025 01:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="CfdTtXsE"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F09916F841
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 01:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753060891; cv=none; b=eHCnVZV0swi9K5eAbKZ4aj4DQIpKxLjeamTMtnjkW0nNExvZF66ScXCOpo5pRyDdVgGWM8nDpgKxLOhrkoqNwZtNgX+Pod/UBDIuylKisXyPvPJIJixIBDXZ5mQW/D7/r0M7vSszg77MPGE4eT4LZQiZKj3B2CHWE/3KYR1UrLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753060891; c=relaxed/simple;
	bh=+MJ1Ymv+daQPTYNiE58qhqypmAUkFSHCG3m1YGa7Ftw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8iTvUN0O/fEhO6JIrbaHh6lMcdVCN+NaluW42UvXpkGw2uIH0KTbUJMzc/4aqFW+wz7iD3bRxvAqo9y7+8cekRqkQuDoh32LC49/UJfhBRBwb/dLpOEqOmm+38ERZBDlz8vCjoPg+SVhqIRb8/l05e0uz7RDbSC0DCpFJ5RqpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=CfdTtXsE; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e278d8345aso383615885a.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 18:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1753060889; x=1753665689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KutpOD99zfcETHTtzhC3inW+4TFUP9RGVT5ONQg1qvM=;
        b=CfdTtXsEJ3Z/tFyirLVR0dMfOklW20d83cMgA7ugjNrvgQoAetyFYX8wYueES72LrU
         qaIfklElvz+HlfIEma3T8Xq6haQD2Lv9rt/ZDLj22xZOChclQZz2GuVldNt7FrOtotju
         mBmDdlsjBjwj5JWJNEJ/g2EdPhg34FKKyh5dXJi1iiSLRBmSLmuk19+f+Yz8zFLqywTW
         IwmwyGaJgfgTMgEDb9aD6jQKhcUhIl1ppYXdNr2/qitygAcyqdpol2XkSQ1vZpKgLER/
         72ODi2/8E2X14ptwRMN0WqosNnqppoGLJczwRkqu563DJGCI+uMUlXVnsBWv+mvOsFJ/
         /zcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753060889; x=1753665689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KutpOD99zfcETHTtzhC3inW+4TFUP9RGVT5ONQg1qvM=;
        b=hor3potXOFznR+c5r+UJ1PSzJKxoBlDZYL6hi7HgIWn124vyLnyLoCylt8g5B9HgZE
         VCV0vxl4JQFOaNkY67OI2meB2KhvvxpCiuIYwNAh9OsjrKxmD04chwNwjPq+XVph6alj
         BfUbixUS29vYe7vrotnvS4Qw/DcYBmguOxc+++f9LMC2UVXfOSjUP2dCUDdaC+MTz6VV
         eRV/fHk4F0+aXQezlN0Vv9bUMjZVFL8+Nsa/imGEvK/Eoi6zCZclvvuqBF7DpfdaYBbx
         +J4kCk7QbMlZzfXyzMFlWBZH460sCkPT4TK/wwFrSbtQS3zaUxoNsoqKz2CCnK8qCV2X
         K9oA==
X-Forwarded-Encrypted: i=1; AJvYcCWAxbhN7kF+LH/5nu7tL7cjmO527VDwtqUtJqdx7ds4/YN01DyYg6HLQ7YyPuNwM2dGA7F9nyPVgIVqaFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCt2nYCYgldkPJqXfUXwPH4917kTwpkD34j3U7CnmUhFVBRaHn
	PSF8dFZzEKMllPA7Jbc6NKBzU8tg1B/0vPaGsbRy3FdtDA994Iyi6wx5pW41pnxZCg==
X-Gm-Gg: ASbGncvc37cduOkRmxTu8cV4s4F/6uS25l7zHtm/q7eGOfHrvCfwmSh2t2XHiujjQ6z
	HML1Vd8sAaAIhdxSPCKY1Ybntofe3vlFIQyUwykUZiQdbXWVJ2llBaRM+BkmT5CaUmSSVl5kM/j
	LCtJ8UZSuLO+mYuBni7z7jG12XVxmeZvsqUi3+BLNxVYcUveQ3D6Hm88vgotdCwMysEqZNli0/3
	wQYeMKG2N0eVR76bAb12r/f46WCiZu3jXz9llLfsW25kvTueFT0f9C26+5fUr57iNyTFngsXoeg
	WNBOy9RtDIKJfUKNAbEkdDTbOcXO/U1gVfUh5+y5qovIrbhU6HAi1kPqNL5HMCAyE+hubcgqUQv
	mt6jyqYXOrFc9+N1+HLdXZns=
X-Google-Smtp-Source: AGHT+IEWJdJ6j/5sk4yCskCysiI2a7M1IGPMx1kIxCHmUxxkULnnKpZ3yKjp41mgb1lTlIPkbNowxA==
X-Received: by 2002:a05:6214:ac1:b0:702:d60c:94ac with SMTP id 6a1803df08f44-704f6ac55c4mr315024336d6.26.1753060888997;
        Sun, 20 Jul 2025 18:21:28 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::401d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051ba6b777sm33924716d6.71.2025.07.20.18.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 18:21:28 -0700 (PDT)
Date: Sun, 20 Jul 2025 21:21:25 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Marco Tormento <mtormento80@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: hub: Move typec deattach before children
 disconnections in usb_disconnect()
Message-ID: <36a75fd9-71a4-4f53-9a35-560cd9cd5687@rowland.harvard.edu>
References: <20250720210847.30998-1-mtormento80@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720210847.30998-1-mtormento80@gmail.com>

On Sun, Jul 20, 2025 at 11:08:47PM +0200, Marco Tormento wrote:
> I tracked down the issue to the following logic:
> - power brick is plugged in
> - monitor is plugged in
> - when I unplug the monitor in usb_disconnect() hub_disconnect_children()
>   calls usb_disconnect() recursively, and this results in
>   connector_unbind() invoked on all connectors, which resets
>   port_dev->connector to NULL on the ports

I'm not a typec expert; in fact I know practically nothing about it.  
Nevertheless, this sounds strange.  The recursive usb_disconnect() calls 
should affect the connectors to the monitor's children and the monitor's 
own ports, not the connector or port on the monitor's parent hub.

> - typec_deattach() is called for each device that has a parent, which in
>   turn should fire typec_partner_deattach()
> - port_dev->connector is NULL though, so typec_partner_deattach() is not
>   called and port->usb2_dev is not set to NULL even though the hub device
>   is actually gone

But that's port_dev->connector for the port on the monitor's parent hub, 
which shouldn't have been affected.

> In order to fix the above I tried moving the code that handles typec
> deattachment from the parent before all the disconnections, this way
> typec_partner_deattach() is invoked for the partner, port->usb2_dev is
> cleared and typec_unregister_partner() is happy.

In essence, you're moving the typec_deattach() call up before the 
hub_disconnect_children() and usb_disable_device() calls.  (The 
sysfs_remove_link() calls get moved up too, but they probably don't 
matter much.)  I'm not saying this is the wrong thing to do or that it 
will cause problems, but it does seem odd.  In particular, it's not the 
reverse order of the way these things were set up when the devices were 
originally detected.

Alan Stern

