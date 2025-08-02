Return-Path: <linux-kernel+bounces-753992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D154B18B6E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 10:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3BD124E0401
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 08:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102B31F8F04;
	Sat,  2 Aug 2025 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dpyz7P3H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B149188CC9
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754124409; cv=none; b=h28tXogfsNAOrbwUfmgny+U4KJa4RvzqAQ83Iizby5E8pn9NfRHvc2VoMoP95ZLQ1l9kWdAK5P5U9ME8dQi8TTl8dWGkvwjWl2w993LhfCpgaGkoAf0t9RCR4lkHMPm7wtr7sW0ZLYm/ansh78opbNZF7yzINmqL5enVqlb2mx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754124409; c=relaxed/simple;
	bh=IiGfI+tePNLyC636DoPw2SRv4Sa4rZ/27F2RfdsgtGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tu1Irj0TTI8LK7QhBm+mg3A1LIwtZCbjUJS3H8XieP9qY6HPy38xd91821Anjm4gz5cE6qtVWW43/Fq5oTw1oTuWV5ozJWuBAPHGnrZ9CY6P7Kvmmm1OZyWN4e/Ep8Pm+GPr5JE9SMN8r1ZJbiS21I7HrgTEap2gLLL8DTAO60I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dpyz7P3H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754124407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IiGfI+tePNLyC636DoPw2SRv4Sa4rZ/27F2RfdsgtGU=;
	b=Dpyz7P3HfGmPL1uVbsLax+Sz97GlY6lFE+ykO6aWv2tsy0la5eg1QpukCRYPIzI8IKBuWr
	8fGwbzesFJOWsXqIG7lltCeA2es7+jvOgD7snvx9rDc6A10GFKevTrT0xzpC2vmAOzz74h
	XBhx9PzPX7KieKhF+2VZOrkoxcGSsQc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-DhHTk9IyO-65OIu3BgrV_w-1; Sat,
 02 Aug 2025 04:46:42 -0400
X-MC-Unique: DhHTk9IyO-65OIu3BgrV_w-1
X-Mimecast-MFC-AGG-ID: DhHTk9IyO-65OIu3BgrV_w_1754124401
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 919331800349;
	Sat,  2 Aug 2025 08:46:40 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.25])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1C1BD1800B65;
	Sat,  2 Aug 2025 08:46:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat,  2 Aug 2025 10:45:30 +0200 (CEST)
Date: Sat, 2 Aug 2025 10:45:26 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: =?utf-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Xiang Gao <gxxa03070307@gmail.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"mjguzik@gmail.com" <mjguzik@gmail.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"joel.granados@kernel.org" <joel.granados@kernel.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbRXh0ZXJuYQ==?= =?utf-8?Q?l?= Mail]Re:
 [PATCH] pid: Add a judgment for ns null in pid_nr_ns
Message-ID: <20250802084525.GB31711@redhat.com>
References: <20250802022123.3536934-1-gxxa03070307@gmail.com>
 <20250802022550.GT222315@ZenIV>
 <15b18541f37447dd8d5dbd8012662f67@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15b18541f37447dd8d5dbd8012662f67@xiaomi.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 08/02, 高翔 wrote:
>
> Obtain the current process pid in the ufs compl command. This scene is possible.

How exactly your module tries to obtain the current process pid?

task_pid_vnr(current) should work and return 0 if the task was reaped.

Oleg.


