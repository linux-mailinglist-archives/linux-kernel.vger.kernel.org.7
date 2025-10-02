Return-Path: <linux-kernel+bounces-840522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA21BB49A9
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA6C3C11C4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1F1265CBE;
	Thu,  2 Oct 2025 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="KlNUOCHl"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F1315853B
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759424290; cv=none; b=ilvGckMdYiIu+N71gxaa6rq12MKonLtgFcOcwJxuivbu/7KGPg7OcntKDVWrnPz+DnjbYeK6g7wJfPtkkrSZ4Jy8QZVIyKGvs873nqXUxXWGgkqoirZq436KR3EHpHykJca7Qfu4wPNylZEm8W3u/e4u/alKjrC7A7kHcsSvcp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759424290; c=relaxed/simple;
	bh=DWjHOxomjkRfeDYzYnh8WXVeqpwtYa01c6QSgT2bshE=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=ly9ouR8NukRT4e9YKH6N4qsq9735nMnqNdjtHbsIFzkMiPG6av5U9ZwoUCz0kpw3M0lAwftTHJYtAM9t0ecjhHpqOBBMSsgNiJ1SIQJfChHu2rknDywRhd/yFYCL1JBcJTJUpPdL4M5P/IMxUnk2dBbpRoqIKDjHKn9hBwtHxD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=KlNUOCHl; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1759423969; bh=DWjHOxomjkRfeDYzYnh8WXVeqpwtYa01c6QSgT2bshE=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=KlNUOCHleB8n4ptUhBF5nTw/mta9Dl9vSMBPnX/ZZcHvUrvxya1qecqsjC9U3F6Gz
	 vK2QYdDXfuwUDiuD7ncN8HkhWlavrn7TxgkZ7KDgyza3FGNvPfJ/gmAM4iiCXMG5S6
	 RUeAL8Kb8c5vnSneWOiJOpr0i7+qJrjPuL4ifPx0=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-XMAILINFO: NaU0Z4p7r7ol0COpNLy7a5OaU4GYJn3OsjzcIqj5LBSL+p7qfrU/MTIFXTnMhM
	 4HoxUw/H7q7+g8X/MbCQFD3pO+gr5gfie3S7RVLXQK7R8OgPKoxmyB0T4QvE/wyeKNT3fDSj4rvBU
	 UT/76zz6GsRnGImu4hWeF4Oe8ltH8lEVXZIyMOXKBJYK4705ejppM2M591gXunv2SrknYS8H0GjDz
	 NQkQfTY+rqW4Dqe/Co6ZKVAL+MQbQ0fuvRLkf6wQ6qi4jVHToFmbq9+sj4yYhaqS9Q1Tj96XJid8M
	 iUr4DT6cVxwE+WXrnYHFL2EgSC0luiTis+4sNmhSlehvYDmRDOpGXyWp/RZ5TgjVJsInZl8Kjo9oV
	 eNLXkdAhXJBqBkUaE4BkMsiGj5p9cNQTAI4XuMJWMNSaTFhhRt9ijqbY1ry0U+ATq52HEBeFp/Ia2
	 fomnRIWgmCZcAdIqsD0ayj8Xw81UgpW/wIzlX8HHf0976DrANVs54M09OZGM3FaVCLimePBjZPhMd
	 pZ5R9PCBhsS7xrsHm6utlf+j8cp4ei8X7wMaOIfl8r+L51esdb4aNjQFME0pY884bTf9Tg+b3nkao
	 +DoW2UsWuFxVxz88wOnMgovJ1b/VmCROhADO472fWD31bfdYzdLK3egdRMdpwf/mGLu/oCT5/1JTq
	 85OS+T9fNDuUILVsUB8YKAX+eZc0nd0pVYaKT1ugVv8rezBtVD4F5IqA2o6p3za88CRR/+E+5BrPZ
	 Je3wWMcjnn9mOJfVOP8oHj17jsZwYi2+pkMVmNauRmvDG17kT87+IZknvMo+YCQhgDYvEB93l1+Wh
	 BnWmBWtA5VUnQdF5kk198lgqdAEY8xxYyIVSH4eu/UeFMBOPzcWbT9EzGZOHk0tp9OEw/aOufuvpV
	 m0if+gROC4EicI8t3UTaL/GjRGiP8tFXX+FQk9/2AFQsaETY/IwKDZkHnTEbQMtkgruWQMtuTRzus
	 gxy5EeA8BFLpdnnZo5kGsEoAGUC2/nxscPhem/a3X8BdQu0e9f2CdUKJiSvgrR6xza3BucOQMqjRL
	 Dx4oSVyDhH2qVoAk2Rwpwzxj/2CTW0FxvYeJekLCBleEdHuFwBAyLLXm33tg0vgEL4Il3b1Cf6BY1
	 Y40iULQd2tsE1g==
Received: from smtpclient.apple ([113.102.238.209])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id D2D18C4C; Fri, 03 Oct 2025 00:52:45 +0800
X-QQ-mid: xmsmtpt1759423965tovxuwfdv
Message-ID: <tencent_6D46195D9B796BFA443B81B519A9DFE5A306@qq.com>
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH] rust: bindings: add `rust_helper_wait_for_completion`
 helper function
From: Guangbo Cui <2407018371@qq.com>
In-Reply-To: <CANiq72ngvZSL72GQ+CwFoaE4ZfakZSPcZk1zrXqyaKEZLWDf-g@mail.gmail.com>
Date: Fri, 3 Oct 2025 00:52:34 +0800
Cc: byungchul@sk.com,
 Liam.Howlett@oracle.com,
 amir73il@gmail.com,
 andi.shyti@kernel.org,
 andrii@kernel.org,
 "boqun.feng" <boqun.feng@gmail.com>,
 bsegall@google.com,
 gregkh <gregkh@linuxfoundation.org>,
 linaro-mm-sig@lists.linaro.org,
 link@vivo.com,
 linux-kernel <linux-kernel@vger.kernel.org>,
 mark.rutland@arm.com,
 masahiroy@kernel.org,
 mathieu.desnoyers@efficios.com,
 matthew.brost@intel.com,
 max.byungchul.park@gmail.com,
 mcgrof@kernel.org,
 melissa.srw@gmail.com,
 mgorman@suse.de,
 mhocko@kernel.org,
 minchan@kernel.org,
 oleg@redhat.com,
 paulmck@kernel.org,
 penberg@kernel.org,
 peterz <peterz@infradead.org>,
 petr.pavlu@suse.com,
 torvalds@linux-foundation.org,
 vincent.guittot@linaro.org,
 will <will@kernel.org>,
 yeoreum.yun@arm.com,
 ysk@kzalloc.com,
 rust-for-linux <rust-for-linux@vger.kernel.org>,
 ojeda <ojeda@kernel.org>,
 gary <gary@garyguo.net>,
 lossin@kernel.org,
 "a.hindborg" <a.hindborg@kernel.org>,
 aliceryhl <aliceryhl@google.com>,
 dakr@kernel.org,
 "alex.gaynor" <alex.gaynor@gmail.com>,
 bjorn3_gh <bjorn3_gh@protonmail.com>
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <C77927A0-0A1C-4492-97F2-FF6502AAC8B9@qq.com>
References: <20251002081247.51255-37-byungchul@sk.com>
 <tencent_13F1EDE0D6B7A44697F31AE274C8E664E908@qq.com>
 <CANiq72ngvZSL72GQ+CwFoaE4ZfakZSPcZk1zrXqyaKEZLWDf-g@mail.gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)

On Thu, Oct 02, 2025 at 12:39:44PM +0200, Miguel Ojeda wrote:
> issue if any -- I don't see it in linux-next, so I imagine it is not
> applied, but "changed" sounds like it was? If it was actually applied,
> please also provide a Fixes: tag.

Yeah, it's not applied yet, this should be squashed into [1].

Sorry, I forgot to check the commit message.

Thanks,
Guangbo

[1] https://lore.kernel.org/all/20251002081247.51255-37-byungchul@sk.com/


