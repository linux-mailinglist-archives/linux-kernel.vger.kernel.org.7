Return-Path: <linux-kernel+bounces-827562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1468BB9216F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B543BA061
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E76730F522;
	Mon, 22 Sep 2025 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU2d17AE"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06E430E820
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556553; cv=none; b=hEg3F4hocOkGxU6W84vfUPsZdyc27rljuOt6kLQRFqfau92xlwN88RzUxGAXnWal1KmgubCFi2BcIPZGxJi6HjDWI63WV+rzpulxiNEA8giRp0W8xXH703eqYL2P4DMLuCXvrYoao4ekdwprtSBzHbxVEITEkLeK/BQP3obi8BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556553; c=relaxed/simple;
	bh=zKhd5kbeKppM9tP5IFjWUEKG0aqUGHUSQZU5BziWV5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DU4tqmFzAz/Rvu1t9hHq6UHejTGOukh8cNf7h+0uQvY5F25+T/a9ANKkYvtj8ntBJKM2cJxpLY+/7LwEuo4Tu9Nbe/dus9HCf4Zg9DbNZLEqKOjcfWDVwBsB5K2drhVV23f+1JWwCeP5oQGuwg4DcYi+s76isM1yw2Vs1g8+HYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU2d17AE; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b554bb615dcso781453a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758556551; x=1759161351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKhd5kbeKppM9tP5IFjWUEKG0aqUGHUSQZU5BziWV5Q=;
        b=UU2d17AEdgZo0hXBP+da84jso5VtjRDy7WPhwcBVdUCWRg86ZDW7jUJ2DAIpo1xhui
         rZUz4KZtEK1ttsDq0XDWvl1iQxN9Wv83BiTASUVoamOmNmE9H0gB1SqVra6O4sqyi6qY
         PVmXU09CortLhpbUCBEYqnINwXSUjVhzzdDU97p3xkvbBYLtU2pgiAgTg+GJJO2lc0t5
         S3nTjLUDoiOmybue9k5KAkEDOzAOapn7vDWsCvRDc3Fwvd/7s/8zfPzrFKA6RmQI4EqS
         3YR8dd3LFEGXGtCmJciU8IY+8vd+XoM/UQzMkF1baskDJ4xyZJgItmZpOi+vgStraXMJ
         mIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758556551; x=1759161351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKhd5kbeKppM9tP5IFjWUEKG0aqUGHUSQZU5BziWV5Q=;
        b=sxn2Tr4YRk1wH+J1Tav4GUlx42Zq9jHARWYlVHFO+MeCwW21vPW+zwA0s/IRhjq7hF
         zghrqRBrxTByVB0PTb5CH5Uru6d4FmhQk66w4G5FF1Gu539mnCnEIbOppb2ELALaXORz
         9OKjJ/vRerJSVhoea/WRtvbaAygLAj73n1NwASxwn/IOewWsEqqdEXHRRAW9MIvE5k2w
         XWkk816p+wcrMGKrpDEIH8nLp21+AM9HsxqTYweidT78jA7Vhu5QoIXUqREQ50/krSt4
         1yUXGaWIxCyNLls8h94wlZIUkiiKIxqt/Yfq1CdozvNB7STa44MV05TnTgB0tOpM9a7e
         +9kA==
X-Gm-Message-State: AOJu0Yy80iiJiRtjprca3odfiLIJKkn++rMZAx9eRASGDOXhSfJnHMxt
	Jx0MqBaXKLUR6R6YP7DbC4PzNZVXNI/QyozJP93n+qRxtb8nWeEZsTkS9vdXg4T+23Vk3k93yr9
	JcGlVijsFvl38IVv/1DR2tNhIaErwDfE=
X-Gm-Gg: ASbGncsV1nEgWkbEwb9omRZt0cy+niU22yv7DinIXSW14LtaWBiLspyVx0znpuPXqfp
	JpCWcGFKUaDYLCtUVv1/M8NPPZEAM8UKHayohAxNZDWPktKfqz4VZzQovhxqNB0d/sukp+kCJCB
	PKFcShndGceu4mpkfn2evd6Bn6dzRQmFI9al04CvoNZ9Uy/OHQ73v+mSpQFT/woG4Efk02r//aZ
	NzosJILktXzJue3ertnQsY=
X-Google-Smtp-Source: AGHT+IH/craAUuC/Ixwy2yPxGrtrESRbjWs3dZ3PdaVtMPq8BSoZaDjBShXnKIrESsMMpNfHvaum0Bou7tkghT7mhMM=
X-Received: by 2002:a17:90b:5547:b0:330:4604:3ae8 with SMTP id
 98e67ed59e1d1-330983416fcmr14935056a91.21.1758556550651; Mon, 22 Sep 2025
 08:55:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922131725.378691-1-quic_ckantibh@quicinc.com>
In-Reply-To: <20250922131725.378691-1-quic_ckantibh@quicinc.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 22 Sep 2025 08:55:36 -0700
X-Gm-Features: AS18NWA6PUw6EJIsjtt8GzyvEAwdmMm-NuBlC2YazjESbIsx1mYkY0Xf2wO7h-4
Message-ID: <CAEf4Bzagg84sok_Ho7Z-eaEst8go47f1fxSdtAWy0M4cPN04zw@mail.gmail.com>
Subject: Re: [PATCH] libbpf: increase probe_name buffer size to avoid format-truncation
To: Sanjay Chitroda <quic_ckantibh@quicinc.com>
Cc: linux-kernel@vger.kernel.org, andrii@kernel.org, sanjayembeddese@gmail.com, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding back bpf@

On Mon, Sep 22, 2025 at 6:17=E2=80=AFAM Sanjay Chitroda
<quic_ckantibh@quicinc.com> wrote:
>
> Yes, This is due to GCC being overly aggressive with its warning.
> Also, Here is regression commit:
> https://github.com/torvalds/linux/commit/4dde20b1aa85d69c4281eaac9a7cf
>

It's not a regression, (potential) truncation is expected and is fine.

