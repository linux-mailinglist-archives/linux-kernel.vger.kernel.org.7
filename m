Return-Path: <linux-kernel+bounces-861194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3371FBF2068
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E7E404BBC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9436C23E320;
	Mon, 20 Oct 2025 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u7YATRdy"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA4C2405ED
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973161; cv=none; b=LC++fttB7LnIsi5oLGDhaBL8XQPu0xXSDS1hNyKJv+c/4XCXeF2iqRkIfBuMEe62i5C+f5Ae/YeSsc1F4ZBVDBuCZT1ebJ5diEW3IDrx7q1fqOwO6Wqhfd7ZHN+sQLJZnyJEVi7O1vQXbmiA+PtrtXJ2S85QXCSzOjKOk5Hrc4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973161; c=relaxed/simple;
	bh=xOuPESK8A8ZsLAMfQkDlhPH9utzkEu7vEwNlSg8sCvA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=HmlCdtQAhxTc7Yb5fVhU1TkAw5tk8mB/aOh4oLECozag/0l1/aLJHk2r6HX5uc7eFL/LTw4s3HZvVOh2pKOHncviA9tSttOwB/iSM0MtbAW42lTtqkhTQsbu9dDpEYK6GlIkAjCBm08CiyqMSwIBH5Bgn+Lw3HGV0PbBwVe/4vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u7YATRdy; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46b303f7469so35302625e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760973157; x=1761577957; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOuPESK8A8ZsLAMfQkDlhPH9utzkEu7vEwNlSg8sCvA=;
        b=u7YATRdyfxGr5Ef3fOzbO8mHJTbllMykVxqzgsXIYu+uanfTZ3aOzKbvAMoLRUhlMN
         yEMwq+CD5W6iHPn27fpHLpnsNQdtPIUiodC7TkPJ3BHW5JLuxR9v6dszCjQaUMUfynFL
         Mv3ojBMuST2+CnPe6PWrQatrJoR6G3xBcGUKz1q6M6qmhbezZxVeNQsRsrrkOjVQXQLw
         dskg33Z5pk3s6hGCLCkvkRUSts1E7DXOV0FE+UxDcFeo/juNgPTEFjvR5teyadZlNOuc
         OCSiQiGZMsAfGVwn1rjaddR+R3FTT0t2x8q21Rvrz8eckHSUoPbCFHRuaQMvswRTUfbi
         +Wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760973157; x=1761577957;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xOuPESK8A8ZsLAMfQkDlhPH9utzkEu7vEwNlSg8sCvA=;
        b=RK5DL1lNO9DkrsTLehANqevChNaCWgx+qe5q8MZwi+JfVzAOdCYKQsLrUNNis5E4Oq
         IO2WvOdttp5k5BUwohC+dqcXoZzyv70UeFC3Y8a/tGoWcD1ZY7BozgktXmkiXoMcR1XH
         xfbSnik0ukD71zlBvu/c8bB/k4Qo+jD0IwgkXcPsHoFobZ0XdCKl4aiToPVsKBNMF1HL
         D6Grsd+sv0nGQq+P1R2ibAvBhTxO4Tl486bT/Niyo/kgY7pU++J9cYHWSBT2EoyT+9U2
         4HvmTToIMduAOIprjtI9UQGU1A0rphjYdFW6BufH3aEPlUm2ve1qfXbopa/c9N7NACkP
         6b1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWccYkbo7IqsOxJIkJuae4pM+QApnEVnoE3x2PCDuE87sX9d3h7UKU+Xmk43YsJQsRhBmMW8fIhlQIfiM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGMwq84qvNG/wbkshKzLaE0+kesRNE/cJDvZ+SI7cghKiWSQE+
	fsRVpE/End+FdJtg/5dBse5KHbAEBqbScUQnMDyjS5tXF1akgCwoSky6/TCvM5v6QFI=
X-Gm-Gg: ASbGncvCtPm4dvM8HKyYxj6bWwVSmMHMuFyUcfsMBrRZKRFqqML201JFyKj2dkBvW0T
	cAxfIriHBn37Fts63A7li4w9+f153rqwdBwDOaLjQRAkUxHmcUSst3pDMvwk0NRaUmqNae99XMR
	NukmQhlW2F5lR/Ls9KnC/nFeTuWcnbyViNmRFw0m3A63Mu1yCwYeO5ArK6kbOD71obBauRJ0/A5
	V7+nFxRyeVDkX8nZKJhD8BeMv0Ayvv+WV7QKEFxmRK/VvuSIkkbY1tNHmi8clR6m5b60wiG98R1
	ZriHwvs9JApgSTJD3Tve7wwa7QY5qawiZaoF5aYkORN9sf9E0f0grF8B4bCn0NTDyag03jtU+Pj
	665yLa8dJ+JEgC75hiK4VMI8M+p8CddauvTYkRjiV0dqHjPKoYcVRA4TdNjKqyiV0u5ejnefpST
	6WKZU=
X-Google-Smtp-Source: AGHT+IECoZa3fLJQgVws7eIYsvFcF+35q6vBM+53448SH1/XsTn40cSP7eTVirwX0Mnmnf2V5Dy6mQ==
X-Received: by 2002:a05:600c:3581:b0:45d:d5df:ab2d with SMTP id 5b1f17b1804b1-4711790bf23mr94199515e9.26.1760973157411;
        Mon, 20 Oct 2025 08:12:37 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:9f99:cf6:2e6a:c11f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47152959b55sm154497755e9.6.2025.10.20.08.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 08:12:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Oct 2025 16:12:36 +0100
Message-Id: <DDN8VVZ4ZL38.13JN04FQV1254@linaro.org>
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Srinivas Kandagatla" <srinivas.kandagatla@oss.qualcomm.com>,
 <broonie@kernel.org>
Cc: <perex@perex.cz>, <tiwai@suse.com>, <srini@kernel.org>,
 <linux-sound@vger.kernel.org>, <m.facchin@arduino.cc>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <Stable@vger.kernel.org>
Subject: Re: [PATCH 2/9] ASoC: qcom: q6adm: the the copp device only during
 last instance
X-Mailer: aerc 0.20.0
References: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>
 <20251015131740.340258-3-srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20251015131740.340258-3-srinivas.kandagatla@oss.qualcomm.com>

On Wed Oct 15, 2025 at 2:17 PM BST, Srinivas Kandagatla wrote:
> A matching Common object post processing instance is normally resused
> across multiple streams. However currently we close this on DSP
> eventhough there is a refcount on this copp object, this can result in

even though?

> below error.

[..]

Best regards,
Alexey

