Return-Path: <linux-kernel+bounces-750176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AED2B15821
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 06:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D556540A14
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 04:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B5618A93F;
	Wed, 30 Jul 2025 04:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="rl8xorxH"
Received: from r3-25.sinamail.sina.com.cn (r3-25.sinamail.sina.com.cn [202.108.3.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474214A32
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 04:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753850574; cv=none; b=LCkHxE6iRRPDlxK3cJCuFk8f02RMIYyJz5UCYUTHJGIyf9MuwK3Y26ps8tUU2ez242aG6iqAKgJsOHv/uUtjT7vj3yGh8cNGQjFL0ZQdk1ogMCGJBmcBW37tXOWU3/cCvB8B4m28PjqUYjovKF+VPIxSuQC459KkwcEEeOa4VNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753850574; c=relaxed/simple;
	bh=BNYDSuEHkX3UtIYATWxiuBVF1H6ZMSUKGBj4/cGhLFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MdMpZoTLtrtdXy1PcnrjxJEWPzBbCs2PJ5TYSkDXAsU8SjLwr7BvkDo//wFNwA4n9i8aDcaG85cewrk6EHcfRa2BNlojL6XYtqJu2pO870upmoTuTZ8ARTL8U/BVqkG/tSi++KNSkw7GVutZx2nrGRBcj0z0E/CW/tIFVx7Trj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=rl8xorxH; arc=none smtp.client-ip=202.108.3.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1753850569;
	bh=uznuf8zbOQCTVwVBLxMMcuG2IVAIwcvFGZuNNfMxJRw=;
	h=From:Subject:Date:Message-ID;
	b=rl8xorxHjR/z9ziJZYH/Y38U5Ty53g+BaQjrqJLir9us9BAodsTr0q5mjQGMtimgw
	 FOYb4gn6t6I1IHt2WQ2ITalw5/lAkLn8s8O0CCOvrHn89CWHkB79mcxqYKrxeZKMrV
	 RVC93GeHiU0tlX3BIPowakv+i8H7HzJFN7CDLu+o=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 6889A2BC000050AB; Wed, 30 Jul 2025 12:42:38 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4228256816233
X-SMAIL-UIID: 1674B0AC211D4AF4B6AC27BB5DA076EE-20250730-124238-1
From: Hillf Danton <hdanton@sina.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	CoCC <conduct@kernel.org>
Subject: Re: Code of Conduct violation complaint
Date: Wed, 30 Jul 2025 12:42:27 +0800
Message-ID: <20250730044228.3448-1-hdanton@sina.com>
In-Reply-To: <aHanGu9nOGOegUg2@duo.ucw.cz>
References: <13a6b8e3-a35a-425d-bafc-006e0a52599f@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 15 Jul 2025 21:08:10 +0200 Pavel Machek wrote:
> Hi!
> 
> I publicly apologize.
> 								Pavel
> 
Feel free to contact your lawyer before any step forward, Pavel,
according to the First and Fifth Amendment in usa, particularly
before making sure how you violated CoC, based on what law. Why
and how next week was selected, based on what?

Hillf Danton

> On Tue 2025-07-15 09:28:19, Shuah Khan wrote:
> > Hi Pavel,
> > 
> > The Code of Conduct Committee has received a complaint about your
> > interactions on the mailing list which are in violation of the
> > Linux kernel code of conduct.
> > 
> > We urge you to apologize publicly to make amends within the next
> > week.
> > 
> > Refer to these documents in the kernel repo for information on
> > the Code of Conduct and actions taken when violations such as
> > these happen.
> > 
> > https://docs.kernel.org/process/code-of-conduct.html
> > https://docs.kernel.org/process/code-of-conduct-interpretation.html#code-of-conduct-interpretation
> > 
> > thanks,
> > -- Shuah (On behalf of the Code of Conduct Committee)

