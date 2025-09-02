Return-Path: <linux-kernel+bounces-797108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B46CB40BEA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1ADE1B6512A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E405341AB1;
	Tue,  2 Sep 2025 17:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="7Cl/uZv8"
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DDA4C9D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833734; cv=none; b=JqTi4qiUbF+nriB1Xzcba+IO1JT6yPb3KrAZeLjmOAGD8p2uQFo9pbfrCHNotDgwAkxSlO09kFY49Kftwttv8WvcTpXWtGThBPg8My+jPqSersXp+dlzxzSod7VvJJDTEEo9VcDv2kJjOZ1M8xVCmpMuHrqxLaNOJQvoqHRiRQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833734; c=relaxed/simple;
	bh=caNi1WTaY1PBmgvFG1iziDFspW4QZ71jXiPuJS+YpJ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GxdLVBJNcsLG9BqS+2UQDjG0m0F3M9SpHjsl6TgShpIZuYm/AcmbJN6ji7u3un0ke3vMUUcyQ0EvozvM+YvHd6XKcN1GNFnr8v/4ooHny+eStRzpi2uyVXlx1zqXYgu0heoUcIlqrXGtcX1Q9WOm3LTch8Z/kruUZ7cPLsaVAhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=7Cl/uZv8; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=caNi1WTaY1PBmgvFG1iziDFspW4QZ71jXiPuJS+YpJ8=; b=7Cl/uZv82nSI7JHiknpfCncR7w
	nxg8cIDIcy70XRDq/NqOQ9Nt/f9d3DDm/qQXrq6J6cOT46fH36p+DqJt3A2/BHSgoPd+9R5S3hept
	vMye4f7fFCBi3We5Z/n1MC6lN2/OrVHwhiaUv21RZ0c69eiLzxybHuS0a7vMSC0vnoQSPcDycwZ/U
	2GGYYGDFW6gK4SApils870TFRVtaxF4zzYVUARCnNsQY+dX1RneVVMwH0Rb4C+JnyNk+/cVAvUKMn
	N5+/Svil8D+ZHiQjbwCHVU/cI81Ajn+DB0itaZ6aLKZelofW+fJTmgNp7zwVDkao2hnbCmGNNqa3I
	qmjjPCZg==;
Received: from [213.55.222.174] (helo=[10.155.49.253])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1utUBv-008DlI-OD; Tue, 02 Sep 2025 17:49:08 +0100
Message-ID: <7481bbd7c6652a963f132191dc622f1003938706.camel@codethink.co.uk>
Subject: Re: SCHED_DEADLINE tasks causing WARNING at kernel/sched/sched.h
 message
From: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, Vineeth Pillai
 <vineeth@bitbyteword.org>, Daniel Bristot de Oliveira <bristot@kernel.org>,
 Luca Abeni <luca.abeni@santannapisa.it>
Date: Tue, 02 Sep 2025 18:49:06 +0200
In-Reply-To: <a90ee087c4dc21bbd548c933256d6b4a877a9fd9.camel@codethink.co.uk>
References: <a90ee087c4dc21bbd548c933256d6b4a877a9fd9.camel@codethink.co.uk>
Organization: Codethink
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: marcel.ziswiler@codethink.co.uk

Hi

On Tue, 2025-09-02 at 16:06 +0200, Marcel Ziswiler wrote:
> As part of our trustable work [1], we also run a lot of real time schedul=
er (SCHED_DEADLINE) tests on the
> mainline Linux kernel (v6.16.2 in below reported case).

Looking through more logs from earlier test runs I found similar WARN_ONs d=
ating back as early as v6.15.3. So
it does not look like a "new" issue in that sense.

[snip]

Any help is much appreciated. Thanks!

Cheers

Marcel

