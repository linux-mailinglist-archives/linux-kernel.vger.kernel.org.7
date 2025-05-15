Return-Path: <linux-kernel+bounces-649593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B03C8AB8683
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 14:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8513AA2AF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 12:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8345F298CA6;
	Thu, 15 May 2025 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ri8X1V/R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64312222CB;
	Thu, 15 May 2025 12:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747312582; cv=none; b=pUR+AlO/Cg+VnC7RGLUpBRHnROmkkO7d7rQ9gAfiS7ka81N5fyuzG2RbzF1mxYYudY30n0GZZMrhoiputHcbpD3UXkL85+B5gjcqVr2GFjmQlDTRpcZ452g4q6uDW/1zT+DQBMR1PA5Q1Nne6XBxRk4TJTqWi95twKuF+ajVlw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747312582; c=relaxed/simple;
	bh=GWuWXPf+Al/gDQ1STMocGcMVo0JocNTWRjrrAr0INos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qx3mpvbXWZMxF5bIPefRH4eww3LmCSPQOd0Gy7/NV7rwvaloDCuRwAbUjA8yPWwiMxpaVFz0IjDh4LWaCoDcpE5og2F52V8+O5TEsXM+6ozgE8SfB6V6Rql0YXue1UsZGa5fN6ssD0qa8dygJdiRpcD9mJyryvbX73M+6ecEew8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ri8X1V/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835D6C4CEEF;
	Thu, 15 May 2025 12:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747312582;
	bh=GWuWXPf+Al/gDQ1STMocGcMVo0JocNTWRjrrAr0INos=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ri8X1V/RAdNFG4RQr0G9E9/8sZSuKU9+1lsAQ6So3eV41+iKfVhM1KOqJbnednF//
	 QNtzlq9JEhMtCzPX5wFWsboKTaExaGauwdrSwn7pq8d9Zf4e04mGGvimOhq06ilo+I
	 VIQqcK50nMp84eYDtF1TbJSRNlzt7Fp0o7QnCroVONqaZuHt8QqPgAWGLF0CV47X/+
	 sGB+OU+jvV6LNsSmZdBhp70pxwQKI8/LqYXt0yOb+ycJWCFOJNBHYooYblDTMu6zA4
	 2APICHdsyF/swqhGENdFENXhULH7KA3ZxsUoX7aL839Rv3WIBuvWzXcK2Y5zajYkkN
	 8L31CODkjLfBQ==
Message-ID: <919e357c-729e-45a9-82ab-6c2fdaa31288@kernel.org>
Date: Thu, 15 May 2025 14:36:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: ata: Convert apm,xgene-ahci to DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250512215731.4178567-1-robh@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250512215731.4178567-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/25 23:57, Rob Herring (Arm) wrote:
> Convert the APM X-Gene AHCI SATA Controller to DT schema format. It's a
> straight-forward conversion.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Applied to for-6.16. Thanks !

-- 
Damien Le Moal
Western Digital Research

