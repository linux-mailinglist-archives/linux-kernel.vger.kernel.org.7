Return-Path: <linux-kernel+bounces-763221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EF9B211F7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2A77501557
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C94A29BD9C;
	Mon, 11 Aug 2025 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhMFRURt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F5F311C2B;
	Mon, 11 Aug 2025 16:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928942; cv=none; b=U2U3b4Tl15XyfxQhVCy/VXNfuOExSTG2L0pQTof9gduoyjte5Ii5BwT+FgXiWFum0yj7/ctZNAnPov0ZcgNqPrG8a+GVoei0XrNlJdMVf3aZQn/ikErlOWeR1alZp4IroVWfxDiVCPW6LZODS7BcTv4qb2x+TNSLjQ9OhX3ZTGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928942; c=relaxed/simple;
	bh=2sNkub0rzCDFrLMqsijjTc6D2BdtnRb0YA+BhBUHoA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/xG3lr5QU3vfNQXFIT1JxkJycXlHEfWlnVDdPRi6YpTNEfD7BJZhTsdwMij3iXII6lwGQ2qR/7rSlB4hEMy/bIcOgCBToHbbZ8dA5ujuEA0NXngvZv1bIVgbJroSryvdXYHc+HnwCMVqs2mciulhI6C49RuXUfMdHRjC//uRM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhMFRURt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7E5C4CEED;
	Mon, 11 Aug 2025 16:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754928942;
	bh=2sNkub0rzCDFrLMqsijjTc6D2BdtnRb0YA+BhBUHoA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UhMFRURtW47AcwG9fIq7vLE/b/7KOD0bmD2KL4OHFKzfwOdAysm9C0iXLz8nxQ3/D
	 6leg016ReYBNmXlalpid/AL0/8lGZABoHmyJXEPdistDkiOgqhjK5YeM6qkmA7laPu
	 zDedfz1QjrHhgsQyqTGYtQA1l3Q7OtSTBREfVxE3r9oPPH9HKiOlnNHhf/0vAqndWp
	 nztvGLC2ppB/DO4az1AbNZDEhUqzjKlRpVa/xKNAR+MIPRCLutSDO9nqDsSylafqH6
	 NLG6pN1wsxDqDP9FsHIZloqzmU1u1GZ/nWza9YDGoKmwL2K0KrclFmxbQCXHyYQWxs
	 3Ph2mFCVQi1nA==
Date: Mon, 11 Aug 2025 11:15:39 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH RFC v2 0/3] arm64: dts: qcom: sm8750: Add Iris VPU v3.5
Message-ID: <bs4bgbyrph4xwsianzvkonpmi72muihob2yaip3gz4yhlqon2s@uvbwrhlr2xlr>
References: <20250806-b4-sm8750-iris-dts-v2-0-2ce197525eed@linaro.org>
 <175449112353.639494.1882304081892662235.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175449112353.639494.1882304081892662235.robh@kernel.org>

On Wed, Aug 06, 2025 at 09:40:29AM -0500, Rob Herring (Arm) wrote:
> On Wed, 06 Aug 2025 14:38:29 +0200, Krzysztof Kozlowski wrote:
[..]
> arch/arm64/boot/dts/qcom/sm8750-qrd.dtb: /soc@0/video-codec@aa00000: failed to match any schema with compatible: ['qcom,sm8750-iris']
> arch/arm64/boot/dts/qcom/sm8750-qrd.dtb: clock-controller@aaf0000 (qcom,sm8750-videocc): 'required-opps' is a required property
> 	from schema $id: http://devicetree.org/schemas/clock/qcom,sm8450-videocc.yaml#

Can anyone help me understand why required-opps is a required property
in the videocc binding?

Is there a valid level below "low_svs" that is otherwise selected, but
insufficient to keep the clock controller ticking?

Regards,
Bjorn

