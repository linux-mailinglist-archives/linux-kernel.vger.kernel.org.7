Return-Path: <linux-kernel+bounces-861137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC09BF1E01
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E710818926AD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC3D212550;
	Mon, 20 Oct 2025 14:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d2AqTT8B"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95416207A20
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970944; cv=none; b=N5Hp8TQXrm7AyK9g3DaBlfenorI7IpneHon4XbQeBLFE13OeBXZrUMtxru+iAQY15m5eeGJWflSUCwG+Zuw80ff0WsWzGZnLAijeyEZiGbJlop3nNcTz5dJbIt2aILJLphixZKLumkry/ioZCE4u+Ac4LxmScgRSZin5T2q7JAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970944; c=relaxed/simple;
	bh=wnYcHCuWZPeDg0BhtNTyWjiqcR00ZxV8ZoizojL33d4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=k1UcFUybxBmBrS3cIe31i0+VdExAu50P1REgRXbixeHF88WCAQMuyKGhG0Kjp0LhrBjvw8fZ6F0KAP5Z9B8Y0t3zgVzvP1aKgQ9JEB3hz62qGCjsxyFxWgAgnx0baZhuwAmf/K00FBmuM8Abrc+Ne6Ywc2iX+AIwLFcKPXl5kiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d2AqTT8B; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47117f92e32so27723045e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760970941; x=1761575741; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnYcHCuWZPeDg0BhtNTyWjiqcR00ZxV8ZoizojL33d4=;
        b=d2AqTT8BxzPj06lnKw6PwUJzRS+mwWO7kv/T733MPM/8/v2UJ7JIJ7YOMFEsWsNerH
         4OgL6OPIHWQH3nKHWloRaGOcD505CyRF8IAgWjMiYW7hUxp1OXL6XDDXiKGh6tlW51pG
         kBq0osh+V0mvARgbBlgRFkA9rvenk/VWPQaj4FF1nmVGtW+TAGTAcdcExxc8DHNglECM
         ++sW6a/gCUqj+be+dGO2FngG0CXfTBbupgp5vL4AfzcciOqP+k5DZbB3copDn4pigIQ+
         b2aOF8iZK+V/NXkm59eAx+BdFW4ZaHCJyXYaHZU8CIzkyVb6QjYklfvfUdHOqV7kko4j
         9+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760970941; x=1761575741;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wnYcHCuWZPeDg0BhtNTyWjiqcR00ZxV8ZoizojL33d4=;
        b=P+tg8AcmYX7MmJWXt3cciFYF6M5ziDdr8gyd1HONVXn8zs4Xi8PW+WLLrxEhKU0Va3
         nYPwExittnD63Y9RiL7BX0QKig9eo+hxEkY7hHNVhekoD6PvPJcSp8eoBOEPVEGLRBqg
         inSfG44LdO23KBpI7G99nfRcAlgMpLBPbDSx7ndH+wTnx1JSOU7FKnYJTqp10C+OiUSL
         joDBLG7Tp3TSO6kWI3txe0M07DAs9QfkSu7+JjBA8T2cazleitdq1t1vR4y//KSmgLrN
         DEY865z3mXnf2se/8hcbYrW+BVVYkZoh8REdix31Tti7h0Tg/H1u+J53hh+HKDhTj8Ix
         NCtA==
X-Forwarded-Encrypted: i=1; AJvYcCVrawfLx/iVMujmRhbUtkXiRP+JXmmsG5YrquEfxhH7XTgl2ay6YqBYvzgxInvnzk3IWQgN70i9TqJ7F0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnfgTcpOsaA8NTfby7U3bTargfdTYTNvreB4+Vr2NHeT5I5y4q
	Spf79PmFngH7sKJVJDEPs6c1+YxIeW970+8VAMdkJ+on9W4OvlEPRUJ5Dqb4vaZi3HM=
X-Gm-Gg: ASbGncsu5DNBeDKNqVQonfv3faTMcjzL3a5VHXY90ICk8TcNAYbrw1ZCADCS3wpc8at
	IEQxHpD6w+cUb6tV81eolfb1s3dzdYdMXgWcJeOBc8bnMNIhhTG9FNO6lpwMGemxvOjj7mypwiP
	mHcRbaAfVY9McfOiduSWoOC+TnceR7eErbqI0o94yafBsz0TCtl5NtboKEDSRrH0EvoBPcHCnJp
	5BoU21+IeG24XO/DKEGblkQqSg749itLoIb2eTa3URVxj1YTC6X1i5HFNZErKkvmgX6T/Fl0imZ
	0GVfMa1MtRbT7afVcDkuTDHQxD+PTrR5WnJCjwxpS9seV8bzuWyQriJMrP2PUmhqjevuZDOtfJM
	Z12C2yL13VZVPlwpivhVy4Frpiqa1bInGsLMLQir/saGKx2F3QqRPfP+bdqSUKEiBvl84+tKHPC
	e7AeFxGyHLTe2vAg==
X-Google-Smtp-Source: AGHT+IHstFjqQkjl+l0ywmYAHSUcGq43w07vFirmXX5YtQRkOxuXbbdfyJ4BicC1pVjbmBltYMMqIA==
X-Received: by 2002:a05:600c:828d:b0:471:11a3:a289 with SMTP id 5b1f17b1804b1-4711791c5f5mr91081905e9.27.1760970940912;
        Mon, 20 Oct 2025 07:35:40 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:9f99:cf6:2e6a:c11f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710ed4b47fsm116778775e9.4.2025.10.20.07.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 07:35:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Oct 2025 15:35:39 +0100
Message-Id: <DDN83LOTCUIP.5O05FBN02AZB@linaro.org>
To: "Srinivas Kandagatla" <srinivas.kandagatla@oss.qualcomm.com>,
 <broonie@kernel.org>
Cc: <perex@perex.cz>, <tiwai@suse.com>, <srini@kernel.org>,
 <linux-sound@vger.kernel.org>, <m.facchin@arduino.cc>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 5/9] ASoC: qcom: q6asm: handle the responses after
 closing
From: "Alexey Klimov" <alexey.klimov@linaro.org>
X-Mailer: aerc 0.20.0
References: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>
 <20251015131740.340258-6-srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20251015131740.340258-6-srinivas.kandagatla@oss.qualcomm.com>

On Wed Oct 15, 2025 at 2:17 PM BST, Srinivas Kandagatla wrote:
> For record path, multiple read requests are queued to dsp in advance.
> However when data stream is closed, the pending read requests are rejecte=
d
> by the dsp and a response is sent to the driver, this case is not handled
> in the driver resulting in errors like below
>
> q6asm-dai ab00000.remoteproc:glink-edge:apr:service@7:dais: command[0x10d=
ac] not expecting rsp
> q6asm-dai ab00000.remoteproc:glink-edge:apr:service@7:dais: command[0x10d=
ac] not expecting rsp
> q6asm-dai ab00000.remoteproc:glink-edge:apr:service@7:dais: command[0x10d=
ac] not expecting rsp
>
> This is same for both write and eos.
>
> Fix this by allowing ASM_DATA_CMD_READ_V2, ASM_DATA_CMD_EOS and
> ASM_DATA_CMD_WRITE_V2 as expected response.
>
> Reported-by: Martino Facchin <m.facchin@arduino.cc>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

I was also reporting this error months ago.
Thanks for fixing this.

FWIW there is also DSP timeout error on Audioreach-based platforms.

Thanks,
Alexey Klimov

