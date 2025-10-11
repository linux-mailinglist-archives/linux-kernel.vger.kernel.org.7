Return-Path: <linux-kernel+bounces-849088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02847BCF2D6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 11:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE4504E5BD1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 09:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7E123AE87;
	Sat, 11 Oct 2025 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="iYjUpjD8"
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D171DE3DB
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 09:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760173903; cv=none; b=jbL1KqUfoEbbXRZCqbIqe7jHYZBK61sbn6GjUyRZ7RWw2kkO7IRf+DpEB3hV+3cHAqF5pfhr99VGIvXikGOKTQetCN+lS0CZ/gh8I9NiYgV1eT45SyITFFrX0KaO8oUEK+AcZ9jUzwHjeWoXhb6vDBEw3aJ1/XVlSMFjzsyZOdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760173903; c=relaxed/simple;
	bh=mKTlX9D0tm+y4NmacTtIsSpod4z9mjx0gYmGrQhxiCk=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=iOR+92hZG+pQc6s9p5UozMuC4hpApWnok3n9IHDlgn6tFKVbW/bXA94+eoHsai43bJqwoEvdbCZ7vjxg0WSLGyrkD7z5j6wdwT1NlWsJRLf/mKC/kGAUnS8XhKZc3PAJdt/w9Rgy7xkKQnCQ0eCIgKmVuAFW0IvcbL16mPHHF20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=iYjUpjD8; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1760173888; bh=hB1yQ2wvDFnVAsGe8+bw7k5KCIcmWa16me/L/2WKyo8=;
	h=From:To:Cc:Subject:Date;
	b=iYjUpjD89F2JA0EMJfTJexOom1mO0zviNge15ya/wrwrV1pK3ey5SlbZDM45StSVP
	 V42KLuxcm+slHBL8YzbKsgvGXo9/Y90QfXhwySQ5U/XlGpczt3VgOugipv8U/69uzm
	 cFLqsspahmoghmdHn56ub/6+j4F3xomaBf587awg=
Received: from localhost.localdomain ([116.128.244.171])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id E8928AA2; Sat, 11 Oct 2025 16:58:09 +0800
X-QQ-mid: xmsmtpt1760173089t8bh2rky8
Message-ID: <tencent_8CD1019C5E0B59CEF696BDBFC006361C2407@qq.com>
X-QQ-XMAILINFO: M9IkCq5LT1vIe2oY6YYeV7yycxlQfvPNYmK83Qsdmo2TB1jEO8WB4/882QOu0T
	 uaacG/mse7T6ab6hUcxDiffzo0m4C2fsnvToojWXb+ICY/h8LWZ90FElTqMNKjPgPNENP0c2oEXg
	 pfjrmaTEQW/rAcsKrUzQ7DRqU40XBAEQxFmpDNoAHk0iQ81epwmXUmIofoZaPl8jMiT6IiZgLh5y
	 eUqxEgJwZjFW5nW85uTVYcCpG+l3SXrjAL9iNfymkvnplkbG01hbQDfscDhqGXKMZb2hAO7/j5tv
	 eW3f7V1YccuogU2BQuFSW4uHdTKTTRTsCuedY7wGjSSfvHeFc0cqOW/rayFoBc/3765dcEDAhlg0
	 lufsB3GGhjYESLlWH9TIOH52/o5vUSNDh1dhpw9i7cIvdDEjUYmeeXHbO/7c9QozFeXPjvpz+a8g
	 inuUWJWZF0cgodO9lOcGDfnjGAgb8rPht/IhGvT0PCACHznYqeKqjp4VdzgLm7dUqQK5bPUBn6Nr
	 O30X5mBGOZOnikOjnNEVVsttfF6Rgl74vIH5ppfUWSlkkjm4euxiJmxKej9zkMHmOE5BJMF3QUVE
	 1drml3g5qUIzNdFYiD5soKMegVggZihnhQCklb7IxPEb0FRxe0T33hyI22Poe0ZLl8N+nErKCXYY
	 nCG8zEU4fJD/wPSugDewpAH7XRlanwyD+hTA4orKaxBAMf5rVOZsfF8KkO/0xmKDZ4qsltQB0FWD
	 XXfUYqa0U9wkvWHPA22Y8nFIJbVc++6chPBZ4gc01UC/It11fieZ9gETYXlj/mZ9VbXKp5HTbbes
	 e3o82IhI0JnLLWnTDpyCrnVvroAP8Wus8zZ5QJdGQzyvSP66432MTYjVA4ek7pn69DosQxNpqdZ8
	 Y4rZs1KBdpLcM8NM772BdlZqF+4yLbKdTD6/rFfFSyqCcTZKmAu+Q39agEjEvCDnXdk1n1GA36jh
	 bW+Rsn/gbfUElfkz2nBF1Ox13eQtuelVMn09oc73NOiv4Co0wt5C+AS99m3m24WTOsr65XSgGoBq
	 knCqr2aaTiInuW0Jvc6e30wr6ujAM8U7xevVkZi9rK1AEz48MEVjnNmVDEbi1QoGbrcp03fTxfgz
	 g/lP8s0VbaXHXDn9VpdTI0RCE0tmVBPHX0MyY8
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Haofeng Li <920484857@qq.com>
To: John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Haofeng Li <13266079573@163.com>
Subject: [Question] About off-by-one error in tk_aux_sysfs_init() loop
Date: Sat, 11 Oct 2025 16:58:08 +0800
X-OQ-MSGID: <20251011085808.777213-1-920484857@qq.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

While reviewing the timekeeping sysfs initialization code, 
I noticed that in tk_aux_sysfs_init() the loop condition 
i <= MAX_AUX_CLOCKS appears to iterate one more time than intended.

Code in tk_aux_sysfs_init():

for (int i = 0; i <= MAX_AUX_CLOCKS; i++) {
    char id[2] = { [0] = '0' + i, };
    struct kobject *clk = kobject_create_and_add(id, auxo);
    // ...
}
With MAX_AUX_CLOCKS defined as 8, this loop runs 9 times (i = 0 to 8),
creating sysfs nodes for 9 auxiliary clocks. However, according 
to the comments, the kernel only supports up to 8 auxiliary clocks.

This seems like an off-by-one error that could lead to creating one 
more sysfs node than actually supported by the architecture constraints.

Would it make sense to change the loop condition to i < MAX_AUX_CLOCKS 
to properly align with the intended 8-clock limit?

Thanks for your time and consideration.

Thanks,
Haofeng Li


