Return-Path: <linux-kernel+bounces-671466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC07EACC1C5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 10:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6323A2FDA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 08:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19396280337;
	Tue,  3 Jun 2025 08:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxsw.ie header.i=@nxsw.ie header.b="Pm6Geqtj"
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16E27082A;
	Tue,  3 Jun 2025 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748938153; cv=none; b=plgaAk3Ze29MFb0uRHruqSc+1rpXshK+7vWH/RxgSMpqNl8db1rHsGVGWQafG9pqGQEfYiMdlWxbW9TcHqKtlirzZjozrhHdcdC5ymPhI6wMHsBnpgPvYh7XtRd8kG9gAVS7MlQVOBF7bMhwhoSVz66UgBdfsTEGeYQ2YmTsXqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748938153; c=relaxed/simple;
	bh=3FbuYhnxCUYm9zEmp2vQNtPmoz1rele8HKaLLXzBZvI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rodMH/O1VIuGN9Fngw00N2MrHwqOwN64+oUYgSVljZmFa8nskWzOHRN+5F/vlp51oJmTFkAMWNI5zMe6mDcTzqpQLrRqZXgehhKkj38r3AKLvfW400k43KWuzDwyzlMPHSfo/E+QGsLLtj8Fh8YyPqqRmBwldiylhBa5ns38F0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nxsw.ie; spf=pass smtp.mailfrom=nxsw.ie; dkim=pass (2048-bit key) header.d=nxsw.ie header.i=@nxsw.ie header.b=Pm6Geqtj; arc=none smtp.client-ip=109.224.244.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nxsw.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxsw.ie
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxsw.ie;
	s=protonmail2; t=1748938148; x=1749197348;
	bh=8kFxVwEZH78mOzEG3WvfbZFtiMz2Y1+zNflx2lK/eDI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Pm6GeqtjcyMF/06wIPAPFiWZyp4P/x9sIpCsDIm/5jjqsIpeMc2I5Ecp+tpVNh2uV
	 kHhbDNZexQFW47qulC2rnZy59eP5bxhKumWXOHXeB4UErVOkha5Ps/U2sZM2NXVVQ5
	 Cgyq0s/KH6wqiF4ID1cmbHqvT9t5sUXgdJH8YEhHr9qUUrHkW4s4A6aZ/LAj7dBRTb
	 fEe6FYFiSVFb2UlDRAzAtINqFjfB6443sRVHPRZAWMoykRtEugQVNmai1Vv5jF7VQ1
	 X26unQsR/s3fssZwKNoLk4LlLKUePlK1kLb1CvsGvYX4OUDtSyeKorw97DBKPVMZe/
	 yxtCQRUZyQ5bg==
Date: Tue, 03 Jun 2025 08:09:01 +0000
To: Jagadeesh Kona <quic_jkona@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, Dmitry Baryshkov <lumag@kernel.org>
From: Bryan O'Donoghue <bod.linux@nxsw.ie>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>, Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v5 17/18] arm64: dts: qcom: sm8550: Additionally manage MXC power domain in camcc
Message-ID: <a12393de-9ecb-4388-aee3-73e833ba1f7f@nxsw.ie>
In-Reply-To: <20250530-videocc-pll-multi-pd-voting-v5-17-02303b3a582d@quicinc.com>
References: <20250530-videocc-pll-multi-pd-voting-v5-0-02303b3a582d@quicinc.com> <20250530-videocc-pll-multi-pd-voting-v5-17-02303b3a582d@quicinc.com>
Feedback-ID: 136405006:user:proton
X-Pm-Message-ID: b35d30c4c414c86405ddc850c95cf1f9a7759865
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30/05/2025 14:21, Jagadeesh Kona wrote:
> From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
>=20
> Camcc requires both MMCX and MXC rails to be powered ON to configure
> the camera PLLs on SM8550 platform. Hence add MXC power domain to
> camcc node on SM8550. While at it, update SM8550_MMCX macro to RPMHPD_MMC=
X
> to align towards common macros.
>=20
> Fixes: e271b59e39a6f ("arm64: dts: qcom: sm8550: Add camera clock control=
ler")
> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Reviewed-by: Taniya Das <quic_tdas@quicinc.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/q=
com/sm8550.dtsi
> index 92017caedbbbea12eb2e43f2e9f5bcad0c0ee40c..e9bb077aa9f0b8be28608d4a0=
345aae7df8cd167 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -3333,8 +3333,10 @@ camcc: clock-controller@ade0000 {
>   =09=09=09=09 <&bi_tcxo_div2>,
>   =09=09=09=09 <&bi_tcxo_ao_div2>,
>   =09=09=09=09 <&sleep_clk>;
> -=09=09=09power-domains =3D <&rpmhpd SM8550_MMCX>;
> -=09=09=09required-opps =3D <&rpmhpd_opp_low_svs>;
> +=09=09=09power-domains =3D <&rpmhpd RPMHPD_MMCX>,
> +=09=09=09=09=09<&rpmhpd RPMHPD_MXC>;
> +=09=09=09required-opps =3D <&rpmhpd_opp_low_svs>,
> +=09=09=09=09=09<&rpmhpd_opp_low_svs>;
>   =09=09=09#clock-cells =3D <1>;
>   =09=09=09#reset-cells =3D <1>;
>   =09=09=09#power-domain-cells =3D <1>;
>=20
> --
> 2.34.1
>=20
>=20
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>


