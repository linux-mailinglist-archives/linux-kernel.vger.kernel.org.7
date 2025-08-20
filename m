Return-Path: <linux-kernel+bounces-777908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47251B2DF15
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3801C46018
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E75125DD07;
	Wed, 20 Aug 2025 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="BbCSXI2i"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4874226B2D5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699361; cv=none; b=kKD0jlQWnnModt2nodGS7y0Dg4RyMGQe8GZHYlLHjEI82Np2+nvbyVzmCLLbRhx6YX007ThUgrnWpvXZ0c0LZchStV2n785BRVrzLKxdYjNV4hbESxenxqr6wnODywyfsgzT9HCxM4WIJQ3iUvAFsJWD6C6xqFyVGQ1/5GLoyss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699361; c=relaxed/simple;
	bh=WQ1gYz5tG/8r8LeNQSmKhOgpG4fz7gr7tw12p2IjheM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qcbat0sLx0YrvBq4o4arPSECGg0cRMN9NldRjOD0knwQuwl1ruHvacBOmdGtPwaPGokaiJZarxpQ1p+tAJTcGwMGMtkRADfaqmqe7SjJBQu9kvqr3rqToJU4+NEJ0KbDbHqm/E8FM3dqMMnkrX4TrtE592r/sAwYcojPvHLPdMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=BbCSXI2i; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1755699047;
	bh=qVU8dJiD0szyL70Q7oZmKD9hFxcV/KWKx2kfm3CAlfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BbCSXI2izdnkxLUlscLx/epcM4n3DreO8ehdZ3+59NDAmSvKSOEfk7We0Fd/0Jc62
	 AQe1FuOPeYwuVyf0z1kHsv2/npiAoOo7wHtANvmQVDPtwLnaXW2r6QGe5yg+OR4rzO
	 cVxTt7mBt9urzhG7qhGio7+Jhnk2FhWDKOi2b9tc=
Received: from zm.. ([2408:8340:a29:3fc0:20c:29ff:fe69:94c7])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 11E0967F; Wed, 20 Aug 2025 22:04:30 +0800
X-QQ-mid: xmsmtpt1755698670t7uxhqi0q
Message-ID: <tencent_34F69492AC1630B90634E94C886712651306@qq.com>
X-QQ-XMAILINFO: NtJxv7tGYeanYi0iqPU0HtP+iKxTe9DBdSGrtLeqVRqVLGJs5cMhQIl519Ok/w
	 /P3pLwFhT3yy4yUzzIuAnBtw0YknAmAognebrVI2SFyj6VZG7ox5/h1mzwCliw943LL5M0dYZTAl
	 8Rk4Ux+Oo6qhGBU0CP8cOLKNd9JHxTvhLf/IsstXPSxNHGcraGSf9z4AYtSo+gmAe9F3DzZav05v
	 rBjWV8C0cJiOJEvKeV5A/g/+mQlbVzFZWdr7bRpEjoF++Drh/q6iCBOcAYYGWHcrBSx8UK2Ow5aw
	 6cpzEcpqs9y6eXIpo2MdVgVeEZfWoQPtdAkMnB30e9WA7Iqhf9wbDsl34vw7qONf1wvOG4j6F1fh
	 RTN/DtCNNOoQX2qNoSZutJ0NinO7E+DrJXo83SaQ9QCs9hMsAEqXZEyxK3SD+FxEUuk3be69UT0e
	 WWthme+Lh5ra5EQat23DtWzJiDD/BycXvJygJw/6zc5oiZQ0yqn7kueF2zxdPkHVixZP4TgUynxo
	 s4pf/2P95Wa/f4yRZpWH9VvZtyY7Z1XKkAp/yrLm9lQhv/o/SAmYuhS95ZXqdF/bA4WDSEPQ/fMm
	 qHEYtcPM6AkBBF3zi1VgkJZIdc+4bAkJcyDHikMnJtMQmDRtltKDC/nIocnJATNVTx9udGc50nlw
	 QOHLDe2gq1QJuBZSUZsv6BAGMk03BJEeA5fp2Hyt76+UlnSeQNRs1LoIyqNPxKKhg0O1GNFrznUv
	 u3ejiUXOd06KT0Rr0lU/r9gMJhPbqsei4KwzwOmhXi3Ve/eGu6KlAJyUtYBnvjGnyZJIJ32PuTQM
	 tepeiQeVGKS+LVlfwC1a25nmvRr8XcawlmLc58NYOC2uKGRPXqEdMRuVh9c7FHdO5E/Rl6lLsNZN
	 eedxWZmr68+s8paFBbitZ+jMvf9GID7uCeKX39uYj5AT8tRUKPapUKMhtIfP970JUpj4NagsyTPt
	 RTlRIT+ewfP3AVsMbQPjGj30lAVie6+yohBjaK+B6zp+MLvyIsKxBhuvD/9UELFcOAsvFCZMhDN+
	 vauG1ESNvoybvu4SpPVlFNFUd1XApt4LIdsdF7Y6Z7g2nQypx7Gh+cDyI57Vo35fVp2cIpax3UPD
	 yiRv3zN0WGsRmvO2uKvb4F7ly1yEhcnFs0VZVI
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: zhoumin <teczm@foxmail.com>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	teczm@foxmail.com
Subject: Re: [RFC PATCH] kobject: fix uevent helper execution order issues
Date: Wed, 20 Aug 2025 22:04:26 +0800
X-OQ-MSGID: <20250820140430.2146390-1-teczm@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025081956-untie-elude-7880@gregkh>
References: <2025081956-untie-elude-7880@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Hi Greg

Thanks for your patience.

> Why are you not looking at the SEQNUM value?  That should be what orders
> the events, right?  Otherwise how would any of this work?  :)

> Also, what usermode helper program are you using that requires a binary?
> What is wrong with udev?

Due to historical reasons, our system does not use udev and relies entirely
on custom shell scripts to handle kobject events.

The helper_lock and UMH_WAIT_EXEC in the kernel ensure that the uevent
helper serializes the execution of our shell scripts. That is why I
proposed the RFC patch to change UMH_NO_WAIT to UMH_WAIT_EXEC—for our use
case, this change provides clear benefits without downsides, aslo it avoids
blocking like UMH_WAIT_PROC while improving script execution order.

Regarding SEQNUM: using it would require parsing and tracking global
sequence numbers manually. In contrast, using a file lock would allow me to
focus only on serializing events for the same kobject, since events from
different objects don’t require synchronization.

If you believe this patch isn’t suitable for mainline, I’m open to
implementing a SEQNUM-based approach for better event ordering instead.

Best regards,
zhoumin


