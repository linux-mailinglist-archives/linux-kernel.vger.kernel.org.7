Return-Path: <linux-kernel+bounces-751618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFA5B16B83
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 719C87A6846
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F6B23D2A0;
	Thu, 31 Jul 2025 05:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u5j54o4O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D3E13B284;
	Thu, 31 Jul 2025 05:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753939770; cv=none; b=aUxYnquMoxNpkP4cxkvSjKcexAlU4ty9oW9Mi9VE6a5vpF4ZjPsryHrfOXUvIqPBOB336K70qGeoULj1fj6AsPsyYNyr3ou5elRlb0gq6DbsfQer7YCwYS28E2njfFfmSuo8AsWRz4qWaRKT6h3VlJGGIJhVhZ0KD5jDCo3X7AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753939770; c=relaxed/simple;
	bh=/IdXjZYSJoAkISSpqioyA198U7HNB0nE1iTZAs89knY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMjll+c3uSF0A+Ks3++1PBVZ585VP1PXclokks1d5gn16r4eziOVSwCMfVzYj7dvyHVtKOKc36TrPqGbD0rolQSvrsf0cDhJLMIvVYCxtIAJ2+yeGWwm3OXriukwrLIRyJqeupN0H0822i6u71rWMQDAHWcVkMhkOjH0pgULPQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u5j54o4O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A48C4CEEF;
	Thu, 31 Jul 2025 05:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753939769;
	bh=/IdXjZYSJoAkISSpqioyA198U7HNB0nE1iTZAs89knY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u5j54o4Oh/WR/7IVETP/LU3M90jiWwZyCGFdAln4aRJC52pKddXT8MXSX4EDHjPfa
	 m01YvwVgcqpZv4vc27v9ASX9XIbUHBW6ZbFtkSr4xixlGE6ulvB+pzUb2KTyYXgfQ4
	 LPOPR5KzA8KIfGBYEDzTXXvklEsa/Vgpv9jQLOfg=
Date: Thu, 31 Jul 2025 07:29:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/20] rtl8723bs: cleanup and style improvements for
 better readability
Message-ID: <2025073101-playful-easeful-3008@gregkh>
References: <20250726043218.386738-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250726043218.386738-1-vivek.balachandhar@gmail.com>

On Sat, Jul 26, 2025 at 04:31:58AM +0000, Vivek BalachandharTN wrote:
> This patch series includes 20 commits that clean up and improve
> the style and formatting of the rtl8723bs driver in the staging tree.
> The changes address spacing issues, indentation, comment formatting,
> blank lines, and minor code clarity improvements.
> 
> No functional changes are introduced. All commits adhere to the Linux kernel
> coding style guidelines to enhance code readability and maintainability.
> 
> The patches have been tested and are ready for review.
> 
> Vivek BalachandharTN (20):
>   staging: rtl8723bs: fix spacing around operators
>   staging: rtl8723bs: remove unnecessary blank lines around braces
>   staging: rtl8723bs: add blank line after function declaration
>   staging: rtl8723bs: remove unnecessary space after type cast
>   staging: rtl8723bs: remove space before tabs
>   staging: rtl8723bs: fix overlong lines and clarify lengthy comments
>   staging: rtl8723bs: align asterisk in block comment to fix formatting
>   staging: rtl8723bs: fix logical continuation style by moving to
>     previous line
>   staging: rtl8723bs: fix indentation to align with open parenthesis
>   staging: rtl8723bs: adding asterisks in multi-line block comments
>   staging: rtl8723bs: remove space before semicolon
>   staging: rtl8723bs: fix excessive indentation in nested if statement
>   staging: rtl8723bs: fix unbalanced braces around conditional blocks
>   staging: rtl8723bs: remove unnecessary parentheses around assignment
>   staging: rtl8723bs: remove unnecessary braces for single statement
>     blocks
>   staging: rtl8723bs: add braces to all arms of conditional statement
>   staging: rtl8723bs: add blank line after variable declarations
>   staging: rtl8723bs: fix line ending with '('
>   staging: rtl8723bs: place constant on right side of comparison
>   staging: rtl8723bs: merge nested if conditions for clarity and tab
>     problems
> 
>  drivers/staging/rtl8723bs/core/rtw_mlme.c | 506 ++++++++++++----------
>  1 file changed, 285 insertions(+), 221 deletions(-)

I understand wanting to get this right, but it's the middle of the merge
window right now, and you are sending new versions for no obvious
reason.  AND you are sending multiple versions of them.  Right now your
submissions look like this:

  Jul 26 Vivek Balachand (1.9K) [PATCH 00/20] rtl8723bs: cleanup and style improvements for better readability
  Jul 26 Vivek Balachand (1.0K) ├─>[PATCH 14/20] staging: rtl8723bs: remove unnecessary parentheses around assignment
  Jul 28 Vivek Balachand (1.1K) │ └─>[PATCH v1 14/20] staging: rtl8723bs: remove unnecessary parentheses in conditional
  Jul 28 Vivek Balachand (1.2K) │   └─>[PATCH v2 14/20] staging: rtl8723bs: remove unnecessary parentheses in conditional
  Jul 30 Vivek Balachand (1.3K) │     └─>[PATCH v3 14/20] staging: rtl8723bs: remove unnecessary parentheses in conditional
  Jul 31 Vivek Balachand (1.5K) │       ├─>[PATCH v4 14/20] staging: rtl8723bs: remove unnecessary parentheses in conditional
  Jul 30 Vivek Balachand (1.5K) │       ├─>[PATCH v4 14/20] staging: rtl8723bs: remove unnecessary parentheses in conditional
  Jul 30 Vivek Balachand (1.5K) │       └─>[PATCH 14/20] staging: rtl8723bs: remove unnecessary parentheses in conditional
  Jul 26 Vivek Balachand (0.9K) ├─>[PATCH 03/20] staging: rtl8723bs: add blank line after function declaration
  Jul 28 Vivek Balachand (1.1K) │ └─>[PATCH v1 03/20] staging: rtl8723bs: add blank line between rtw_roaming() and _rtw_roaming()
  Jul 30 Vivek Balachand (1.2K) │   └─>[PATCH v2 03/20] staging: rtl8723bs: add blank line between rtw_roaming() and _rtw_roaming()
  Jul 30 Vivek Balachand (1.3K) │     └─>[PATCH v3 03/20] staging: rtl8723bs: add blank line between rtw_roaming() and _rtw_roaming()
  Jul 30 Vivek Balachand (1.3K) │       ├─>[PATCH v4 03/20] staging: rtl8723bs: add blank line between rtw_roaming() and _rtw_roaming()
  Jul 30 Vivek Balachand (1.3K) │       └─>[PATCH v4 03/20] staging: rtl8723bs: add blank line between rtw_roaming() and _rtw_roaming()
  Jul 26 Vivek Balachand (0.9K) ├─>[PATCH 11/20] staging: rtl8723bs: remove space before semicolon
  Jul 26 Vivek Balachand (2.8K) ├─>[PATCH 10/20] staging: rtl8723bs: adding asterisks in multi-line block comments
  Jul 26 Vivek Balachand (4.0K) ├─>[PATCH 09/20] staging: rtl8723bs: fix indentation to align with open parenthesis
  Jul 26 Vivek Balachand (3.7K) ├─>[PATCH 08/20] staging: rtl8723bs: fix logical continuation style by moving to previous line
  Jul 26 Vivek Balachand (3.7K) ├─>[PATCH 07/20] staging: rtl8723bs: align asterisk in block comment to fix formatting
  Jul 26 Vivek Balachand ( 28K) ├─>[PATCH 06/20] staging: rtl8723bs: fix overlong lines and clarify lengthy comments
  Jul 26 Vivek Balachand (1.0K) ├─>[PATCH 20/20] staging: rtl8723bs: merge nested if conditions for clarity and tab problems
  Jul 26 Vivek Balachand (1.1K) ├─>[PATCH 19/20] staging: rtl8723bs: place constant on right side of comparison
  Jul 26 Vivek Balachand (0.9K) ├─>[PATCH 18/20] staging: rtl8723bs: fix line ending with '('
  Jul 26 Vivek Balachand (4.2K) ├─>[PATCH 05/20] staging: rtl8723bs: remove space before tabs
  Jul 26 Vivek Balachand (0.9K) ├─>[PATCH 17/20] staging: rtl8723bs: add blank line after variable declarations
  Jul 26 Vivek Balachand (1.5K) ├─>[PATCH 16/20] staging: rtl8723bs: add braces to all arms of conditional statement
  Jul 26 Vivek Balachand (1.3K) ├─>[PATCH 15/20] staging: rtl8723bs: remove unnecessary braces for single statement blocks
  Jul 26 Vivek Balachand (1.6K) ├─>[PATCH 04/20] staging: rtl8723bs: remove unnecessary space after type cast
  Jul 26 Vivek Balachand (1.7K) ├─>[PATCH 13/20] staging: rtl8723bs: fix unbalanced braces around conditional blocks
  Jul 26 Vivek Balachand (0.9K) ├─>[PATCH 12/20] staging: rtl8723bs: fix excessive indentation in nested if statement
  Jul 26 Vivek Balachand (7.2K) ├─>[PATCH 02/20] staging: rtl8723bs: remove unnecessary blank lines around braces
  Jul 26 Vivek Balachand ( 12K) └─>[PATCH 01/20] staging: rtl8723bs: fix spacing around operators

If you were sent a patch series like this, what would you do to attempt to
review and/or apply them?

Please relax, wait until after the merge window is over, and then resend a new
series please.

thanks,

greg k-h

