Return-Path: <linux-kernel+bounces-749385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A9AB14DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7DD93B71F1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710FE29186F;
	Tue, 29 Jul 2025 12:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="evWsK+85"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783E928CF65;
	Tue, 29 Jul 2025 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753792074; cv=none; b=UWHc8GAJaXhbWvGjJc9MgjKuBMKaFLdyBRPcuZecVkaKVLAXgduukf88x57/0LViqYkCA5HnQd7orzkl7Z+/PdxuijN3oHem11JT4+0BeaCnY9oF7ViynA/HNNjfDI79h9vfYKX9BMPbVTXGM7eLmxPLNZsxyfkHTT5MkidXonw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753792074; c=relaxed/simple;
	bh=WDhFPBiAmW4VXr1rv0LvlmfI0uza+weYkMJa+rABUlY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ZnjuADuHiC6L9MQYSzVamdqSnO1a35uZ8Z3Iuezb/pR9eN3bnHPwK67rAhONa/b/yp7XbxwZ12FiOxdJIE5tkHD+uWAoBw5AORmHgT0TpfrHu5Rx7OEa8b7OBAsN7u49vw1R7DeCfHbsraA5xRdqQU5VmAwcm1lKCfZ8ccXuNpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=evWsK+85; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753792070; x=1754396870; i=markus.elfring@web.de;
	bh=VBg/acP1p+b75vMLBo3l2d8L+04u2v9F8pzWNMQWcmg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=evWsK+85yrbN1+aTj4I1KcrIphQ8vFr8z+lzhL6Ct9bPN2mETCfOskzwvZ6g7YMJ
	 aQbr0m/3T0mLQPMRCGo0AVI1b8VEE4psfxpwM/eYBRaJH/Ej35roqkSCsNw483K9+
	 ZcOuqaL6+PNXjBAZQm5QzeaQXxY48+Zm1ugilptEHJke2h0fp1ufUqWSa6xbNjWfo
	 AlUuAnf7qyp27rS9VUtUPjcJuUQ7QK8OaxsENVBnrRMCywpSjy+t8eroK3zgCviYI
	 l68ox2v+xA0R7G+p/LlRHh4G6wCswQqUnlt7TukNbJvPoQ0FXjvNfJcJbr1AheN5u
	 uS4GyKt4x+55NScU9A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.201]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8C07-1ulwP70JiV-00BQx7; Tue, 29
 Jul 2025 14:22:14 +0200
Message-ID: <d72608fc-b385-46c2-b0bf-bd78b2a8acc0@web.de>
Date: Tue, 29 Jul 2025 14:21:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Colin Ian King <colin.i.king@gmail.com>, ocfs2-devel@lists.linux.dev,
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Mark Fasheh <mark@fasheh.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20250729114131.1925586-1-colin.i.king@gmail.com>
Subject: Re: [PATCH] ocfs2: Remove space before newline
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250729114131.1925586-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6Deg73Leru24jw1s/thlxGPIL7V6Qb1rAHikBXqwIxp+3fckIy/
 ZKJuSJSfXF8+M6LA58/cd9uqUaOma1PJ18t9BRp3wNqnhyK1xPpIZkMWT1TLO14rR78mj9L
 430yhTR8qdD1HUZgxeC1R7SRHyh6E+Jm4OhQJA5fXhQStRgtTK6+5tvSNbGpwxqK0uhhHxe
 EbFYkaq2ZWxk+RIqapt+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9PkmzxW10Hs=;oCsFZKACuf3WKTiY6bz5xRTeEWn
 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

=E2=80=A6
> Remove it

  Thus delete a redundant character.?


=E2=80=A6
> +++ b/fs/ocfs2/super.c
> @@ -2108,7 +2108,7 @@ static int ocfs2_initialize_super(struct super_blo=
ck *sb,
>  		if (strlen(osb->osb_cluster_stack) !=3D OCFS2_STACK_LABEL_LEN) {
>  			mlog(ML_ERROR,
>  			     "couldn't mount because of an invalid "
> -			     "cluster stack label (%s) \n",
> +			     "cluster stack label (%s)\n",
>  			     osb->osb_cluster_stack);
=E2=80=A6

You may recombine such string literals.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.16#n116

Regards,
Markus

