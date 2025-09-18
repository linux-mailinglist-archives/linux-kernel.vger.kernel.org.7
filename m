Return-Path: <linux-kernel+bounces-773840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E237B2AB43
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11F71B63F94
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3398A22B5AC;
	Mon, 18 Aug 2025 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oj8yDaSm"
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45940225390
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527339; cv=none; b=rwwZ6HnUWqMEQKo/STDtzkUEZQa/igpAXtKZOYjbzm1qGCgEwmGFwkP/6yaHOUdnZwP6iRWWLd6WPfs8+wF9WmzftxQaCrEuwPxMezmyr5/lZidyb/LOoFtgMPJ20cGpRzWy58yzt+uWLAghLyPdHycXBBmNOSrvlQX2+plTROI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527339; c=relaxed/simple;
	bh=FAqQGV3Ke2gx5F8X9Iui2YLCfRBa4dhio9Dqgb/b4WI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BfJmxzGKdIiVEtXbEjwOzUZKcj+vM6gseytiC9YmRneIqBdDCxeym8qvJpggWbLnC5oC+3z/FVjsbdLuJysA1VWwagTRZkBZsph/xRMAatNTJ3snnc6swmbCubq3FJYKUvdgTUmS3YIKxM/LrUXhOTx1DKi4OVBsskzD3UCXYSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oj8yDaSm; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-88432da036bso493410339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755527336; x=1756132136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SFLeRUjEYD3BkpymJXqmECsVI217TETJMUIOSlL8bNE=;
        b=Oj8yDaSma2AZNXoEYSSZlvH024LYXaHwoJ9VJpX5ad4sBSDNU74s5+urKCn1n8G1uw
         Uupwmh3scDns+koPmngFTYwGcU4hEAlRWyV7zm+JT+GnkXa3gEfX2X/TCzTzx+bCPA5C
         8gWR3rWpnk7GxN/65XCBr+e1Q4yJSkjuYWt8ipWzp+87hxqT9pjN30wds29qHC/8IyPj
         ysnYziEkhvRetwBZwj77N+hLWrG2b3SRqpWGF87VGErp8kaqCZIq7CPfYqozbscXN87v
         0Fs9M6weDpClOg8yYKBTZuTF+Z30edQuXUe6/dcypxVsl5zKwBpi96VVwoOGXJm4shyk
         4JvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755527336; x=1756132136;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFLeRUjEYD3BkpymJXqmECsVI217TETJMUIOSlL8bNE=;
        b=fY/eIGqGgE27dcRSTnpKcxU58ZvrpujSkBTjZ+FptP5/V1Z5WVgTVTr+d4Lk+jjHbw
         TFZ/505LFQ5cXgyS2KIK84ZRFv0S8hP1KJ6pe96bLoRvfs5UhYQkiSgzuRGnEHBK+NAg
         RbtPKdNCbejheAaGSS8efTzTSjDid2yYfCLlsJmuA08iRl5vh9xbJ7wMYEv38yTYxC8V
         DPieowKxQR24ecszCqDsm5YIZjPUDv8KnbdJ7ekfYz3OsVELP499gG687Pbz7Gqfv+cg
         JAwX5QL8O0NNJMVeAnhdkyTt8iMEngZyeivZ573zZLRXvuQtM+5p064rpW10kbRA54MX
         7aog==
X-Forwarded-Encrypted: i=1; AJvYcCXuTt+Tjwxynu4FOtsQxpEKrundGteVj+hhRrtpb7TtnT0AN0ZO1oJtahxLY9Vl+likiZY341SfqYnWF0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwiq/NWfqsVOqAUxgreS5TCVwzZvfeqOkcszYgBk9sgow5pAZ8
	VdSw9caD2h94PXWJHp/zXIWfevgzvxr7mmm1CpdApDkg1v+1wNEMUx+aNeBe3gPLG6qhbmaw3wf
	5+Xu2tkA8XA==
X-Google-Smtp-Source: AGHT+IENlrHCKRrHMdWjkYiMqgRbUWykHtySlNXHP6tuneZCk119arXyHoOMub6OTc/yo0028tNgbvEYm2DY
X-Received: from iomg7.prod.google.com ([2002:a6b:7607:0:b0:881:85ed:3c6c])
 (user=jdenose job=prod-delivery.src-stubby-dispatcher) by 2002:a5e:8d15:0:b0:86c:fdb3:2798
 with SMTP id ca18e2360f4ac-8843e4d56d7mr1989631639f.11.1755527336426; Mon, 18
 Aug 2025 07:28:56 -0700 (PDT)
Date: Mon, 18 Aug 2025 14:28:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHA4o2gC/22NwQ7CIBAFf6XZsxhAEO3J/zA9VFgoiXYJ1EbT9
 N/FevU4k7x5CxTMEQu0zQIZ51gijRXkrgE79GNAFl1lkFxqfpSalWdKlCfmKVtMvSuM35Q3yru
 D4z3UXcro42trXrvKQywT5fd2MYuv/dWMUH9qs2CcGWGN5dqokz1fAlG4497SA7p1XT97tkNas wAAAA==
X-Change-Id: 20250625-support-forcepads-0b4f74fd3d0a
X-Mailer: b4 0.14.2
Message-ID: <20250818-support-forcepads-v2-0-ca2546e319d5@google.com>
Subject: [PATCH v2 00/11] HID: Implement haptic touchpad support
From: Jonathan Denose <jdenose@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Angela Czubak <aczubak@google.com>, 
	"Sean O'Brien" <seobrien@google.com>, Jonathan Denose <jdenose@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

This is an updated implementation of the interface for controlling haptic
touchpads.

Below is an updated design proposal for the userspace and HID interfaces,
modified from what one of my colleagues submitted in 2019 [0].

We would appreciate any feedback you might have.

Thank you,

Jonathan Denose
Chromium OS Team

Background
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

There are multiple independent projects to develop a touchpad with force se=
nsors
and haptic actuators, instead of a traditional button.  These haptic touchp=
ads
have several advantages and potential uses; they allow clicking across the
entire touchpad surface, adjusting the force requirement for clicks, haptic
feedback initiated by UI, etc. Supporting these features will potentially
require two new communication channels at the kernel level:
* Control of haptic motor by the host
* Force sensor data from device to host

This document includes two related proposals:
1. HID design proposal, that hardware makers would need to implement
2. Kernel design proposal

Objective
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Develop a standard protocol to allow userspace applications to communicate =
with
haptic touchpads, and minimize duplicated code and effort.

Requirements:
1. Support UI-initiated haptic feedback.
2. Allow userspace to control when button press and button release haptic
   effects are triggered. (Useful when detecting a false click, changing fo=
rce
   thresholds, or sending context-dependent effects).
3. Reveal force sensor readings to userspace applications.
4. Only allow OS-controlled haptic feedback for those systems which support=
 it.

Proposal
=3D=3D=3D=3D=3D=3D=3D=3D

In order to minimize duplicated effort, we propose standardized haptic touc=
hpad
support in the linux kernel.

HID API
-------

Modes
.....

The haptic touchpad should be able to operate under two different modes.

1. Device-controlled mode

The haptic touchpad should start up in "device-controlled mode"
(HID_HAPTIC_MODE_DEVICE), meaning it acts as a normal touchpad. This means =
it
should perform the press and release haptic feedback autonomously at predef=
ined
force thresholds, and send the appropriate BTN_* events.

2. Host-controlled mode

Once the touchpad has been confirmed as supporting haptics (described in mo=
re
detail in the the "Click and release control" section below), the device sh=
ould
enter "host-controlled mode" (HID_HAPTIC_MODE_HOST). In this mode userspace
should take control. From here, userspace will take control over
press/release haptic feedback, relying on the effects sent by the kernel.

Multitouch
..........

The HID API for multitouch reports should follow the Microsoft precision
touchpad spec [1], with the following changes:
* A tip pressure field [2] should be used to report the force. The physical=
 unit
  Type (Newtons or grams), exponent, and limits should be reported in the
  report descriptor for the force field.
* The device will always report the button state according to its predefine=
d
  force thresholds, even when not in device-controlled mode.
* The device must expose a "simple haptic controller" logical collection
  alongside the touchpad collection.

Haptic control
..............

The HID protocol described in HUTRR63[3] must be used.

The following waveforms should be supported:

| WAVEFORMNONE             | Implicit waveforms required by protocol       =
    |
| WAVEFORMSTOP             |                                               =
    |
| ------------------------ | ----------------------------------------------=
--- |
| WAVEFORMPRESS            | To be used to simulate button press. In device=
-   |
|                          | controlled mode, it will also be used to simul=
ate |
|                          | button release.                               =
    |
| ------------------------ | ----------------------------------------------=
--- |
| WAVEFORMRELEASE          | To be used to simulate button release.        =
    |

All waveforms will have an associated duration; continuous waveforms will b=
e
ignored by the kernel.

Triggers & Mode switching
.........................

The =E2=80=9Cauto trigger waveform=E2=80=9D should be set to WAVEFORM_PRESS=
 by default, and the
button from the touchpad collection should be set as the =E2=80=9Cauto trig=
ger
associated control=E2=80=9D.

The kernel can trigger the different modes in the following ways:
* Device-controlled mode can be enabled by setting the =E2=80=9Cauto trigge=
r waveform=E2=80=9D to
  WAVEFORM_PRESS.
* Host-controlled mode can be enabled by setting the "auto trigger waveform=
" to
  WAVEFORM_STOP.

The device must also support manual triggering. If intensity modification f=
or
waveforms is supported by the device, the intensity control should be inclu=
ded
in the manual trigger output report. This allows modification of the intens=
ity
on a per-waveform basis. Retriggering does not need to be supported by the
device.

Userspace API
-------------

Multitouch protocol
...................

ABS_MT_PRESSURE will be used to report force. The resolution of ABS_MT_PRES=
SURE
should also be defined and reported in force units of grams or Newtons.
ABS_PRESSURE should be reported as the total force applied to the touchpad.
When the kernel is in host-controlled mode, it should always forward the bu=
tton
press and release events to userspace.

Use Force Feedback protocol to request pre-defined effects
..........................................................

The force feedback protocol [4] should be used to control predefined effect=
s.

Typical use of the force feedback protocol requires loading effects to the
driver by describing the output waveform, and then requesting those effects
using an ID provided by the driver. However, for haptic touchpads we do not=
 want
to describe the output waveform explicitly, but use a set of predefined eff=
ects,
which are identified by HID usage.

The force feedback protocol will need to be extended to allow requests for =
HID
haptic effects. This requires a new feedback effect type:

/**
 * struct ff_haptic_effect
 * @hid_usage: hid_usage according to Haptics page (WAVEFORM_CLICK, etc.)
 * @vendor_id: the waveform vendor ID if hid_usage is in the vendor-defined
 * range
 * @vendor_id: the vendor waveform page if hid_usage is in the vendor-defin=
ed
 * range
 * @intensity: strength of the effect
 * @repeat_count: number of times to retrigger effect
 * @retrigger_period: time before effect is retriggered (in ms)
 */
struct ff_haptic_effect {
        __u16 hid_usage;
        __u16 vendor_id;
        __u8  vendor_waveform_page;
        __s16 intensity;
        __u16 repeat_count;
        __u16 retrigger_period;
}

Since the standard waveform id namespace does not overlap with the vendor
waveform id namespace, the vendor id and page can be ignored for standard
waveforms.

Click and release control
.........................

Haptic functionality shall be gated behind the HID_MULTITOUCH_HAPTIC kernel
configuration option, and this kernel configuration option should only be
enabled if userspace will support haptic capabilities. Haptic functionality=
 will
only be initialized and used if HID_MULTITOUCH_HAPTIC is enabled, and if th=
e
following conditions have been met:
* ABS_MT_PRESSURE is defined and reporting force units of Newtons or grams.
* The device supports haptic effects according to the hid protocol defined =
in
  HUTRR63 [3].
These checks will happen when the driver probes and initializes the multito=
uch
device.

In the case when the kernel configuration option has been set and the devic=
e
reports pressure and haptic effects as defined above, the kernel will initi=
alize
the haptic device and configure the haptic driver to signal that the touchp=
ad is
haptic-compatible. To signal to userspace that the touchpad is haptic-compa=
tible
the kernel will mark INPUT_PROP_HAPTIC_TOUCHPAD.

With userspace willing and able to take control, the kernel will signal to =
the
device to exit device-controlled mode once a WAVEFORMPRESS or WAVEFORMRELEA=
SE
event is uploaded. From here, userspace will take control over press/releas=
e
haptic feedback, relying on the effects sent by the kernel.

In all other cases, the driver will take no action to enable haptic
functionality.

Summary of normal use-case
1. The kernel waits for userspace to upload WAVEFORMPRESS or
   WAVEFORMRELEASE.
2. Userspace determines when a click has been performed based on its own
   criteria and tells the touchpad to perform a haptic effect.
3. When userspace erases the WAVEFORMPRESS or WAVEFORMRELEASE effect, signa=
l the
   device to return to device-controlled mode.

[0]: https://www.spinics.net/lists/linux-input/msg60938.html
[1]: https://learn.microsoft.com/en-us/windows-hardware/design/component-gu=
idelines/touchpad-devices
[2]: Usage ID 0x30 of HID usage table 0x0D. See chapter 16:
     https://www.usb.org/sites/default/files/documents/hut1_12v2.pdf
[3]: https://www.usb.org/sites/default/files/hutrr63b_-_haptics_page_redlin=
e_0.pdf
[4]: https://www.kernel.org/doc/html/v4.20/input/ff.html

Signed-off-by: Jonathan Denose <jdenose@google.com>
---
Changes in v2:
- Rename FF_HID and ff_hid_effect to FF_HAPTIC and ff_haptic_effect
- Add more detail to CONFIG_HID_HAPTIC config option description
- Remove CONFIG_MULTITOUCH_HAPTIC config option
- Utilize devm api in hid-multitouch haptic functions
- Link to v1: https://lore.kernel.org/all/20250714-support-forcepads-v1-0-7=
1c7c05748c9@google.com

---
Angela Czubak (11):
      HID: add haptics page defines
      Input: add FF_HAPTIC effect type
      Input: add INPUT_PROP_HAPTIC_TOUCHPAD
      HID: haptic: introduce hid_haptic_device
      HID: input: allow mapping of haptic output
      HID: haptic: initialize haptic device
      HID: input: calculate resolution for pressure
      HID: haptic: add functions handling events
      Input: MT - add INPUT_MT_TOTAL_FORCE flags
      HID: haptic: add hid_haptic_switch_mode
      HID: multitouch: add haptic multitouch support

 Documentation/input/event-codes.rst    |  14 +
 drivers/hid/Kconfig                    |  11 +
 drivers/hid/Makefile                   |   1 +
 drivers/hid/hid-haptic.c               | 580 +++++++++++++++++++++++++++++=
++++
 drivers/hid/hid-haptic.h               | 131 ++++++++
 drivers/hid/hid-input.c                |  18 +-
 drivers/hid/hid-multitouch.c           |  47 +++
 drivers/input/input-mt.c               |  14 +-
 include/linux/hid.h                    |  29 ++
 include/linux/input/mt.h               |   1 +
 include/uapi/linux/input-event-codes.h |   1 +
 include/uapi/linux/input.h             |  22 +-
 12 files changed, 862 insertions(+), 7 deletions(-)
---
base-commit: 86731a2a651e58953fc949573895f2fa6d456841
change-id: 20250625-support-forcepads-0b4f74fd3d0a

Best regards,
--=20
Jonathan Denose <jdenose@google.com>


