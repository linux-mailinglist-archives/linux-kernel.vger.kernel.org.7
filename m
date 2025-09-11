Return-Path: <linux-kernel+bounces-811455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 719A1B52953
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CAFF1C21896
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35E12676E6;
	Thu, 11 Sep 2025 06:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jX6jiQ0H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E51C145A05;
	Thu, 11 Sep 2025 06:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757573799; cv=none; b=WKZYKqMgC1F7vYxy3HX220+x1wtzqF5uryzUrLoATcC06D3/v2wNunm/Wt9vfkGZq8KNNLB0Zh6/J02wF4OnuwuuM5AWycTVZ30Q/mCONivbRXMkg7Dbsu4CTwANduHQms/7dZQnieLXthijvdg5AdNodC68z7UeSGzyu6+DOlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757573799; c=relaxed/simple;
	bh=46arA/lH7SdZSTJ5xBxmcsnCS+WGoy0Kg9jo9NDY2A4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=We/IJ5MKo/X9GWyEPsUXyZzTHBOA43dFsjlPEQAPzCrg3oc+WDwZOm6DzP88spn+cbUqDfO0oVRReZnv0e4G+zJOVPfLhrwYUo08wM/1wF9j8RfhuTdr+/x+yguiB1rNpavH/bZeG/aGtmhnEGUeaHnqvqwx/Lh4x1c48l6ch98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jX6jiQ0H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D62AC4CEF1;
	Thu, 11 Sep 2025 06:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757573798;
	bh=46arA/lH7SdZSTJ5xBxmcsnCS+WGoy0Kg9jo9NDY2A4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=jX6jiQ0HN9crosjq+Ay5rxGkn13FbfrZIHJnoR4PSkegHvt3xlIn781XZAWGsgdJ7
	 Fx1ct7OcBLdXcSA+RgSi60bLyoMF7SwqZvRdTDL3t52P8Zt7y70lPhQ8zPhcwYfJ+g
	 lppWW1kKhQ4Xj5Nm6UqCLrkXwaR5oHIIIxGabamNplbFpxvjgdql/sQ+adA925nBeU
	 3/qDUB1n/YPGrHuPV6j+NeQ3GvrMDPhnpHz5gmXA4W1xDPOMA7DAXwpVekOU2tBvcb
	 W9wtZWVL2A4qGXPAUQ5SlzsMY+aG1KmtgFRaE/hvwwzL6vwTmoQxgm5AKnYTFnr/7w
	 9pqip+AAVlGgw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818C7CAC587;
	Thu, 11 Sep 2025 06:56:38 +0000 (UTC)
From: Sung-Chi Li via B4 Relay <devnull+lschyi.google.com@kernel.org>
Subject: [PATCH v6 0/3] Export fan control and register fans as cooling
 devices
Date: Thu, 11 Sep 2025 06:56:33 +0000
Message-Id: <20250911-cros_ec_fan-v6-0-a1446cc098af@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKJywmgC/23OTW7DIBCG4atErEPF8OOYrHKPqooGGGIWMRG0V
 qvIdy/OJonl5Yf0vMOdVSqJKjvu7qzQlGrKYxvdfsf8gOOFeAptMymkEVpa7kuuZ/LniCMPqFy
 n0VsPgjVxKxTT76P2+dX2kOp3Ln+P+ATL63ZnAi449sGSougc4MkPJV/Tz/UjlwtbUpN8ciPkO
 5eN62D6vqVRQNzg6oXDiqvluo3SSWOi8GGD6yfvYPV53bhHAKN7T1rbDW5euBTv3DRu7MESAjq
 nYMXnef4HfgesnaUBAAA=
X-Change-ID: 20250429-cros_ec_fan-da3b64ac9c10
To: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
 Sung-Chi Li <lschyi@google.com>, Sung-Chi Li <lschyi@chromium.org>, 
 Tzung-Bi Shih <tzungbi@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757573797; l=4712;
 i=lschyi@google.com; s=20250911; h=from:subject:message-id;
 bh=46arA/lH7SdZSTJ5xBxmcsnCS+WGoy0Kg9jo9NDY2A4=;
 b=B7QcF+Tso7OCahfqv2JRFF3a8wa3lJpkeGcMTa2CXPT29mcddNiEF8QEln6/+eioVfTsNPtU5
 /IhynE37JxuBq1Y3nYvr727c65S3Jayg1wbuw06lEqXpa0cI/6NnkL3
X-Developer-Key: i=lschyi@google.com; a=ed25519;
 pk=fBhhFxZrEyInLLODzeoq06UxQhKVqNjmZ2680pwMBCM=
X-Endpoint-Received: by B4 Relay for lschyi@google.com/20250911 with
 auth_id=518
X-Original-From: Sung-Chi Li <lschyi@google.com>
Reply-To: lschyi@google.com

This is a continuation of the previous series "Export the target RPM fan
control by ChromeOS EC under hwmon"
(https://lore.kernel.org/lkml/20250313-extend_ec_hwmon_fan-v1-0-5c566776f2c4@chromium.org/T/#t).
There is a change from controlling the target fan RPM value to control
the PWM value, and this version (v6) includes the dropped commit
"update pwm fan control host commands" for maintainers to apply this
series easier.

We anticipate to involve fans connected to EC as thermal cooling
devices, so we can utilize the thermal framework to have further thermal
control strategies.

This series updates the required EC controls definitions, implements the
mechanism for controlling fan PWM values, and registers these fans under
thermal framework as cooling devices.

Adapting comments from the previous series, the driver probes the host
command capability at beginning to see whether a fan is controllable:
  - if command `EC_CMD_PWM_GET_FAN_DUTY` is supported (v0, this is a
    new command).
  - if command `EC_CMD_THERMAL_AUTO_FAN_CTRL` v2 is supported.
  - if command `EC_CMD_PWM_SET_FAN_DUTY` v1 is supported.

This combination is selected as this is the minimum requirement for a
fan to be fully controllable under hwmon framework.

The driver supports changing the fan control mode, and allows to change
the fan PWM value only if the fan is in manual control mode. The power
management hook is implemented as well for keeping the fan control
settings, as EC will automatically restore the control method to auto
when device is suspended.

Change-Id: Ia7789a1ea13a1708893c1f86b7d7706612d7b59d
Signed-off-by: Sung-Chi Li <lschyi@google.com>
---
Changes in v6:
- Rebase to newer kernel commit.
- Fix lines over 100 characters.
- Remove unnecessary out of memory message.
- Link to v5: https://lore.kernel.org/r/20250620-cros_ec_fan-v5-0-5979ea1abb31@chromium.org

Changes in v5:
- Fix line breaks.
- Directly return 0 when there is no error (rather than return ret
  variable).
- Rename CROS to CrOS.
- Preserve Acked-by and Reviewed-by tags.
- Link to v4: https://lore.kernel.org/r/20250619-cros_ec_fan-v4-0-ca11548ce449@chromium.org

Changes in v4:
- Treat fan control is supported without `CONFIG_PM` is enabled.
- Change logic of registering cooling devices for fan from abandom
  immediately to log warning logs, then continue with the next fan.
- Fix error checking logic to use IS_ERR for
  devm_thermal_of_cooling_device_register.
- Revise variable declaration ordering with reverse christmas tree.
- Rename member variable `manual_fan_pwm_values` to `manual_fan_pwm`.
- Use %pe for printing error pointers, and add newline for logs.
- Revise comments in suspend and resume hook.
- Link to v3: https://lore.kernel.org/r/20250512-cros_ec_fan-v3-0-a9f2b255f0cd@chromium.org

Changes in v3:
- Make required EC command versions macros.
- Add `CONFIG_THERMAL` guarding for registering as thermal fan cooling
  devices.
- Add error handling during registering thermal cooling devices, and
  immediately abort the registration if any error occurred to align with
  the thermal sensor registration in hwmon core.
- Add error handling for EC fan communication during suspend and resume.
- Add `CONFIG_PM` guarding for checking whether the EC supports a
  complete fan control in hwmon driver.
- Sort variables order in declaration.
- Separate declaration and logic to different sections.
- Move `cros_ec_thermal_cooling_ops` next right after the operation
  functions declaration.
- Improve describing the resume behavior in documentation.

Changes in v2:
- Change column from 80 to 100 and fix styles.
- Directly store driver data into platform dev with
  platform_set_drvdata.
- Unify the PWM unit (from 0 ~ 255) between hwmon and thermal cooling
  devices.
- Only fetch the fan control mode and PWM value when suspending rather
  than caching values when writing. The suspend hook is thus added.
- Link to v1: https://lore.kernel.org/r/20250429-cros_ec_fan-v1-0-a8d9e3efbb1a@chromium.org

---
Sung-Chi Li (3):
      platform/chrome: update pwm fan control host commands
      hwmon: (cros_ec) add PWM control over fans
      hwmon: (cros_ec) register fans into thermal framework cooling devices

 Documentation/hwmon/cros_ec_hwmon.rst          |   7 +-
 drivers/hwmon/cros_ec_hwmon.c                  | 313 +++++++++++++++++++++++++
 include/linux/platform_data/cros_ec_commands.h |  29 ++-
 3 files changed, 347 insertions(+), 2 deletions(-)
---
base-commit: 5f540c4aade9f1d58fb7b9490b4b7d5214ec9746
change-id: 20250429-cros_ec_fan-da3b64ac9c10

Best regards,
-- 
Sung-Chi Li <lschyi@google.com>



