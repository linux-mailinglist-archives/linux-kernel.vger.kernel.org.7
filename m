Return-Path: <linux-kernel+bounces-879266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 151B6C22AF1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B55B034F328
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323702C11CB;
	Thu, 30 Oct 2025 23:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="IAaauqAS"
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0B918626
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 23:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761866215; cv=none; b=fCIkzHcqmzeGEsMVh+CrIjrwA/16y0vALauCVFy86h14V/PGTD8VeotdtksLzVE84vtWwbN9Xuz3lMMGVhJblONixV79ssH+OGVCc3FV0zdlLh2oSasQXpqc4pvqI0MAOMwOHdwEbx5EVPPCmg2/klMmWAcNRPSk6t9kJTI+ClY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761866215; c=relaxed/simple;
	bh=y/pMhtAY6aDI+qio1HW/3c1HsYOCGlxTJmkqJ+SXXJg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Tlse0SkTYJBYgJ7ANgvtRFfrrwxYDMMOvzFip4P7NzWL0VeQG09TkqculL7D3+ZMNaZtrvxSZmq2N8AO6iL6rn4XpaFB7/JTvx/+NcrUg6w//o/imPAAJbzCzPNbBjk2XBAUJq9wSKi7vnlI/PzqGN/q3ExOHrOfHYP3jgsxG5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=IAaauqAS; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 85701c09-b5e6-11f0-ad1a-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 85701c09-b5e6-11f0-ad1a-005056999439;
	Fri, 31 Oct 2025 00:16:53 +0100 (CET)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 82d3e8f0-b5e6-11f0-80d9-00505699693e;
	Fri, 31 Oct 2025 00:16:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=Gy4xuVB7w4pGiyyG/lYc5237rSMjBJld3aDWEdwUJQY=;
	b=IAaauqASu0lHCi94kRX492ATERYPMYcjbnaWg0aeTVZapm9gupXO1ohzfiUPSaAa4NOChenZ95ylu
	 +9OLZaBsMoGAl3kalYX+JOyZqy+BFpp865tpQjmJTO13kS/slYu/uila6H70wN3n4mNtPZVRRWxErl
	 +V7dr3iK8+1qc6aTkGBqDCZVLbyMqdX2XxAJ+cz+Vrq8WiACt4FvtR9PZKIMtIQBBy2F+clsqH/XP6
	 esxul9KuOUPZVRj4JYME2CTUsVo7dv4DERRZEdzq+zX3qrRbV0CXfs2lodCutGB5L/CMJ0K2DJznGr
	 LQ1YH9NWtXNDA37VuHBDIsUJe8kH5Jg==
X-KPN-MID: 33|r74kNLLGbwWQ1nJhuSb0Zll1AsjR7RPiUa3q+IklmQ4HLbfB7X9FOZdQuFIqLbn
 WniAch+RFgG/ReZyINkWzsw==
X-CMASSUN: 33|+2p858qcRq6PC3aNuxP7FW9krUcvDJ8/QakZzivxnbPMyH8hDVmDGUxSIOGjsiB
 h0BieK78A3/RczEQk7SQoug==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh08 (cpxoxapps-mh08.personalcloud.so.kpn.org [10.128.135.214])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 82cc2ca6-b5e6-11f0-b8d7-005056995d6c;
	Fri, 31 Oct 2025 00:16:49 +0100 (CET)
Date: Fri, 31 Oct 2025 00:16:48 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	Khalid Aziz <khalid@kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Taotao Chen <chentaotao@didiglobal.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	linux-kernel@vger.kernel.org,
	syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com
Message-ID: <37767163.3215767.1761866208997@kpc.webmail.kpnmail.nl>
In-Reply-To: <aoppzgcsml33slovgn2cz4ntmdxczk3yu5zlajh7d5bnsdav7o@lhszynfelx4b>
References: <20251028205857.386719-1-jkoolstra@xs4all.nl>
 <su4qka5wugz3asm3sakmptgeeogx6duj6kc7doom5r4fhdwdcv@ogp4lz5gxn7x>
 <792975039.3142581.1761826973320@kpc.webmail.kpnmail.nl>
 <aoppzgcsml33slovgn2cz4ntmdxczk3yu5zlajh7d5bnsdav7o@lhszynfelx4b>
Subject: Re: [PATCH] Add error handling to minix filesystem similar to ext4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


>  
> Hi Jori!
>

Hi Jan, thank you for your encouraging reply, I appreciate it.

> 
> Well, one thing is handling corruption well - that part of your patch was
> fine and I think it is still useful - another thing are the mount options
> that allow to configure what happens when we find a corruption - and that
> is the part I don't think really makes a lot of sense for minix.
>

I already had a patch for this specific syzbot bug, and tested with the
reproducer, but without the new mount options. What I could do is submit this
and see if the community will accept it. Is that reasonable?

